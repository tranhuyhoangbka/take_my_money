class StripeCharge
  attr_accessor :token, :payment, :response

  def initialize(token:, payment:)
    @token = token
    @payment = payment
  end

  def charge
    return if response.present?
    @response = Stripe::Charge.create(
      {amount: payment.price, currency: "usd",
      source: token.id, description: "",
      metadata: {reference: payment.reference}},
      idempotency_key: payment.reference)
  end
end
