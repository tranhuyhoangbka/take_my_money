class StripeCharge
  attr_accessor :token, :payment, :response, :error

  def initialize(token:, payment:)
    @token = token
    @payment = payment
  end

  def charge
    return if response.present?
    # @response = Stripe::Charge.create(
    #   {amount: payment.price, currency: "usd",
    #   source: token.id, description: "",
    #   metadata: {reference: payment.reference}},
    #   idempotency_key: payment.reference)
    @response = Stripe::Charge.create(charge_parameters, idempotency_key: payment.reference)
  rescue Stripe::CardError => e
    @response = nil
    @error = e
  end

  def charge_parameters
    parameters = {
      amount: payment.price, currency: "usd",
      source: token.id, description: "", metadata: {reference: payment.reference}}
    if payment.affiliate.present?
      parameters[:destination] = payment.affiliate.stripe_id
      parameters[:application_fee] = payment.application_fee.cents
    end
    parameters
  end

  def success?
    response || !error
  end

  def payment_attributes
    success? ? success_attributes : failure_attributes
  end

  def success_attributes
    {
      status: response.status,
      response_id: response.id, full_response: response.to_json
    }
  end

  def failure_attributes
    {status: :failed, full_response: error.to_json}
  end
end
