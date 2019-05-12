class PayPalPayment
  attr_accessor :payment, :pay_pal_payment

  delegate :create, to: :pay_pal_payment
  delegate :execute, to: :pay_pal_payment

  def self.find(payment_id)
    PayPal::SDK::REST::Payment.find payment_id
  end

  def initialize(payment:)
    @payment = payment
    @pay_pal_payment = build_pay_pal_payment
  end

  def build_pay_pal_payment
    PayPal::SDK::REST::Payment.new(
      intent: "sale", payer: {payment_method: "paypal"},
      redirect_urls: redirect_info, transactions: [payment_info]
    )
  end

  def host_name
    Rails.application.credentials.host_name
  end

  def redirect_info
    {
      return_url: "http://#{host_name}/paypal/approved",
      cancel_url: "http://#{host_name}/paypal/rejected"
    }
  end

  def payment_info
    {
      item_list: {items: build_item_list},
      amount: {total: payment.price.to_s, currency: "USD"}
    }
  end

  def build_item_list
    payment.payment_line_items.map do |payment_line_item|
      {
        name: payment_line_item.event&.name, sku: payment_line_item.event&.id,
        price: payment_line_item.price.to_i.to_s, currency: "USD", quantity: 1
      }
    end
  end

  def created?
    pay_pal_payment.state == "created"
  end

  def redirect_url
    create unless created?
    pay_pal_payment.links.find{|link| link.method == "REDIRECT"}.href
  end

  def response_id
    create unless created?
    pay_pal_payment.id
  end
end
