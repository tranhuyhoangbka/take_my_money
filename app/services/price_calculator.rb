class PriceCalculator
  attr_accessor :tickets, :discount_code, :shipping, :user, :address, :tax_id

  def initialize(tickets = [], discount_code = nil, shipping = :none, user: nil, address: nil, tax_id: nil)
    @tickets = tickets
    @discount_code = discount_code
    @shipping = shipping
    @user = user
    @address = address
    @tax_id = tax_id
  end

  def processing_fee
    (subtotal - discount).positive? ? 1 : 0
  end

  def shipping_fee
    case shipping.to_sym
    when :standard then 2
    when :overnight then 10
    else
      0
    end
  end

  def subtotal
    tickets.map(&:price).sum.to_i
  end

  def breakdown
    result = {tickets: tickets.map(&:price)}
    if processing_fee.nonzero?
      result[:processing_fee] = processing_fee
    end
    result[:discount] = -discount if discount.nonzero?
    result[:shipping_fee] = shipping_fee if shipping_fee.nonzero?
    result[:sales_tax] = tax_calculator.itemized_taxes if sales_tax.nonzero?
    result
  end

  def total_price
    # return subtotal unless discount_code
    # discount_code.apply_to(subtotal)
    subtotal - discount + processing_fee + shipping_fee + sales_tax
  end

  def base_price
    subtotal - discount
  end

  def affiliate_payment
    base_price * 0.05
  end

  def affliate_application_fee
    total_price - affiliate_payment
  end

  def discount
    return 0 unless discount_code
    discount_code.discount_for(subtotal)
  end

  def tax_calculator
    @tax_calculator ||= TaxCalculator.new(
      user: user, cart_id: tax_id, address: address, items: tax_items
    )
  end

  def sales_tax
    return 0 if address.nil?
    tax_calculator.tax_amount
  end

  def tax_items
    items = [TaxCalculator::Item.create(:ticket, 1, subtotal - discount)]
    if processing_fee.nonzero?
      items << TaxCalculator::Item.create(:processing, 1, processing_fee)
    end
    if shipping_fee.nonzero?
      items << TaxCalculator::Item.create(:shipping, 1, shipping_fee)
    end
    items
  end
end