module StripeHandler
  class InvoicePaymentSucceeded
    attr_accessor :event, :success, :payment

    def initialize(event)
      @event = event
      @success = false
    end
    
    def run
      Subscription.transaction do
        return unless event
        subscription.active!
        subscription.update_end_date
        @payment = Payment.create!(
          user_id: user.id, price: invoice.amount_paid,
          status: "succeeded", reference: Payment.generate_reference,
          payment_method: "stripe", response_id: invoice.charge,
          full_response: charge.to_json
        )
        @payment.payment_line_items.create!(
          buyable: subscription, price: invoice.amount_paid
        )
        @success = true
      end
    end

    def invoice
      @invoice ||= @event.data.object
    end

    def subscription
      @subscription ||= Subscription.find_by(remote_id: invoice.subscription)
    end

    def user
      @user ||= User.find_by(stripe_id: invoice.customer)
    end

    def charge
      @charge ||= Stripe::Charge.retrieve(invoice.charge)
    end
  end
end