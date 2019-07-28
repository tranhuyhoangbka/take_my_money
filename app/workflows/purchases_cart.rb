class PurchasesCart
  attr_accessor :user, :purchase_amount_cents, :purchase_amount, :success, :payment, :expected_ticket_ids, :payment_reference

  # rescue_from(ChargeSetupValidityException) do |exception|
  #   # PaymentMailer.notify_failure(exception).deliver_later
  #   Rollbar.error(exception)
  # end

  # rescue_from(PreExistingPaymentException) do |exception|
  #   Rollbar.error(exception)
  # end

  def initialize user: nil, purchase_amount_cents: nil, expected_ticket_ids: "", payment_reference: nil
    @user = user
    @purchase_amount = purchase_amount_cents
    @success = false
    @continue = true
    @expected_ticket_ids = expected_ticket_ids.split(" ").map(&:to_i).sort
    @payment_reference = payment_reference || Payment.generate_reference
  end

  def run
    Payment.transaction do
      pre_purchase
      purchase
      post_purchase
      @success = @continue
    end
  end

  def calculate_success
    @success = payment.succeeded?
  end

  def post_purchase
    return unless @continue
    @continue = calculate_success
  end

  def pre_purchase_valid?
    purchase_amount.to_i == tickets.map(&:price).map(&:to_i).sum &&
      expected_ticket_ids == tickets.map(&:id).sort
  end

  def tickets
    @tickets ||= @user.tickets_in_cart.select do |ticket|
      ticket.payment_reference == payment_reference
    end
  end

  def existing_payment
    Payment.find_by reference: payment_reference
  end

  def pre_purchase
    raise PreExistingPurchaseException.new(purchase) if existing_payment
    raise ChargeSetupValidityException.new(
      user: user,
      expected_purchase_cents: purchase_amount.to_i,
      expected_ticket_ids: expected_ticket_ids
    ) unless pre_purchase_valid?
    update_tickets
    create_payment
    @continue = true
  end

  def redirect_on_success_url
    nil
  end

  def create_payment
    self.payment = existing_payment || Payment.new
    payment.update!(payment_attributes)
    payment.create_line_items(tickets)
  end

  def payment_attributes
    {user_id: user.id, price: purchase_amount.to_i,
      status: "created", reference: Payment.generate_reference}
  end

  def success?
    success
  end
end
