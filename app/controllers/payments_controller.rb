class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def show
    @reference = params[:id]
    @payment = Payment.find_by(reference: @reference)
    # @receipt_url = JSON.parse(payment.full_response)["receipt_url"] rescue nil
  end

  def create
    if params[:discount_code].present?
      session[:new_discount_code] = params[:discount_code]
      redirect_to shopping_cart_path
      return
    end

    workflow = run_workflow(params[:payment_type], params[:purchase_type])
    if workflow.success
      session.delete(:new_discount_code)
      redirect_to workflow.redirect_on_success_url || payment_path(id: @reference || workflow.payment.reference)
    else
      session.delete(:new_discount_code)
      redirect_to shopping_cart_path
    end
  end

  private

  def run_workflow payment_type, purchase_type
    # case payment_type
    # when "paypal" then paypal_workflow
    # else
    #   stripe_workflow
    # end

    case purchase_type
    when "ShoppingCart"
      payment_type == "paypal" ? paypal_workflow : stripe_workflow
    when "SubscriptionCart"
      stripe_subscription_workflow
    end
  end

  def paypal_workflow
    workflow = PurchasesCartViaPayPal.new(
      user: current_user,
      purchase_amount_cents: params[:purchase_amount_cents],
      expected_ticket_ids: params[:ticket_ids],
      discount_code: session[:new_discount_code]
    )
    workflow.run
    workflow
  end

  def stripe_workflow
    @reference = Payment.generate_reference
    
    token = StripeToken.new(**card_params)
    pick_user.tickets_in_cart.each do |ticket|
      ticket.update payment_reference: @reference
    end
    purchases_cart_workflow = PurchasesCartViaStripe.new(
      user: pick_user, stripe_token: token,
      purchase_amount_cents: params[:purchase_amount_cents],
      expected_ticket_ids: params[:ticket_ids],
      payment_reference: @reference, discount_code: session[:new_discount_code]
    )
    purchases_cart_workflow.run
    purchases_cart_workflow
  end

  def stripe_subscription_workflow
    token = StripeToken.new(**card_params)
    workflow = CreatesSubscriptionViaStripe.new(user: pick_user, 
      expected_subscription_id: params[:subscription_ids].split(" "), token: token)
    workflow.run
    workflow
  end

  def card_params
    params.permit(:credit_card_number, :expiration_month,
      :expiration_year, :cvc, :stripe_token).to_h.symbolize_keys
  end

  def pick_user
    if current_user.admin? && params[:user_email].present?
      User.find_or_create_by(email: params[:user_email])
    else
      current_user
    end
  end
end
