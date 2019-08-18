class PreparesStripeRefund
  attr_accessor :administrator, :refund_amount_cents, :payment_id,
    :success, :refund_payment, :refundable, :error

  delegate :save, to: :refund_payment

  def initialize administrator:, refund_amount_cents:, refundable:
    @administrator = administrator
    @refund_amount_cents = refund_amount_cents
    @refundable = refundable
    @success = false
    @error = nil
  end

  def pre_purchase_valid?
    refundable.present?
  end

  def run
    Payment.transaction do
      raise "not valid" unless pre_purchase_valid?
      raise "can't refund that amount" unless refundable.can_refund?(refund_amount_cents)
      self.refund_payment = generate_refund_payment.payment

      update_tickets
      
      workflow = CreatesStripeRefund.new(payment_to_refund: refund_payment)
      workflow.run
      # RefundChargeJob.perform_later(refundable_id: refund_payment.id)
      self.success = true
    end
  rescue StandardError => exception
    self.error = exception.message
    on_failure
  end

  def on_failure
    self.success = false
  end

  def generate_refund_payment
    refundable.generate_refund_payment(amount_cents: refund_amount_cents, admin: administrator)
  end

  def update_tickets
    refundable.tickets.each(&:refund_pending!)
  end

  def success?
    success
  end
end