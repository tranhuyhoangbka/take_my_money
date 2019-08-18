class RefundsController < ApplicationController
  def create
    load_refundable
    authorize(@refundable, :refund?)
    workflow = PreparesStripeRefund.new(
      refundable: @refundable,
      administrator: current_user,
      refund_amount_cents: @refundable.price
    )
    workflow.run
    flash[:alert] = workflow.error || "Refund submitted"
    redirect_to redirect_path
  end

  VALID_REFUNDABLES = %w(Payment PaymentLineItem).freeze

  private
  def load_refundable
    raise "bad refundable class" unless params[:type].in?(VALID_REFUNDABLES)
    @refundable = params[:type].constantize.find(params[:id])
  end

  def redirect_path
    params[:type] == "Payment" ? admin_payments_path : admin_payments_line_item_path
  end
end