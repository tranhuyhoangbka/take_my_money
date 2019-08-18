# == Schema Information
#
# Table name: discount_codes
#
#  code             :string
#  created_at       :datetime         not null
#  description      :text
#  id               :bigint(8)        not null, primary key
#  max_uses         :integer
#  maximum_discount :integer
#  minimum_amount   :integer
#  percentage       :integer
#  updated_at       :datetime         not null
#

class DiscountCode < ApplicationRecord
  def percentage_float
    percentage * 1.0 / 100
  end

  def multiplier
    1 - percentage_float
  end

  def apply_to(subtotal)
    subtotal - discount_for(subtotal)
  end

  def discount_for(subtotal)
    return 0 unless applies_to_total?(subtotal)
    result = subtotal * percentage_float
    result = [result, maximum_discount].min if maximum_discount.present?
    result
  end

  def applies_to_total?(subtotal)
    return true if minimum_amount.nil?
    subtotal >= minimum_amount
  end
end
