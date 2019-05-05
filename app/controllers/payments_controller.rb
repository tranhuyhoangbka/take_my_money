class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def show
    payment = Payment.find_by(reference: params[:id])
    @receipt_url = JSON.parse(payment.full_response)["receipt_url"] rescue nil
  end

  def create
    token = StripeToken.new(**card_params).id
    workflow = PurchasesCart.new(
      user: current_user, stripe_token: token, purchase_amount_cents: params[:purchase_amount_cents]
    )
    workflow.run
    if workflow.success
      redirect_to payment_path(id: workflow.payment.reference)
    else
      redirect_to shopping_cart_path
    end
  end

  private

  def card_params
    params.permit(:credit_card_number, :expiration_month,
      :expiration_year, :cvc, :stripe_token).to_h.symbolize_keys
  end
end
