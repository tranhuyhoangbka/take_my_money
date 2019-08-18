class PriceCalculator
  attr_accessor :tickets, :discount_code

  def initialize(tickets = [], discount_code = nil)
    @tickets = tickets
    @discount_code = discount_code
  end

  def subtotal
    tickets.map(&:price).sum.to_i
  end

  def total_price
    return subtotal unless discount_code
    discount_code.apply_to(subtotal)
  end

  def discount
    discount_code.discount_for(subtotal)
  end
end