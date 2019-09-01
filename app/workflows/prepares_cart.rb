class PreparesCart
  attr_accessor :user, :admin, :purchase_amount_cents, :discount_code_string, :ticket_ids, :success, :discount_code, :payment

  def initialize user:, admin:, purchase_amount_cents:, discount_code_string:, ticket_ids:
    @user = user
    @admin = admin
    @purchase_amount_cents = purchase_amount_cents
    @discount_code_string = discount_code_string
    @ticket_ids = ticket_ids
    @success = false
    @discount_code = DiscountCode.find_by_code discount_code_string
  end

  private

  def pre_purchase_valid?
    ticket_ids == tickets.map(&:id).sort
  end

  def payment_attributes
    attrs = {user_id: user.id, price: purchase_amount_cents.to_i,
      status: "succeeded", reference: Payment.generate_reference,
      discount_code: @discount_code, payment_method: "cash", administrator: admin
    }
    attrs.merge!(discount: PriceCalculator.new(tickets, discount_code).discount.to_i) if discount_code
    attrs
  end

  def tickets
    tickets = @user.tickets_in_cart
    return tickets if tickets.present?
    @admin.tickets_in_cart
  end
end
