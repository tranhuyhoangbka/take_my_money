class RefundChargeJob < ApplicationJob
  queue_as :default

  def perform(refundable_id:)
    refundable = Payment.find(refundable_id)
    workflow = CreatesStripeRefund.new(payment_to_refund: refundable)
    workflow.run
  end
end
