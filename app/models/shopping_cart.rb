# == Schema Information
#
# Table name: shopping_carts
#
#  address_id       :bigint(8)
#  affiliate_id     :integer
#  created_at       :datetime         not null
#  discount_code_id :bigint(8)
#  id               :bigint(8)        not null, primary key
#  shipping_method  :integer          default("electronic")
#  updated_at       :datetime         not null
#  user_id          :bigint(8)
#
# Indexes
#
#  index_shopping_carts_on_address_id        (address_id)
#  index_shopping_carts_on_discount_code_id  (discount_code_id)
#  index_shopping_carts_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#  fk_rails_...  (discount_code_id => discount_codes.id)
#  fk_rails_...  (user_id => users.id)
#

class ShoppingCart < ApplicationRecord
  belongs_to :user
  belongs_to :address
  belongs_to :discount_code
  belongs_to :affiliate, optional: true

  enum shipping_method: {electronic: 0, standard: 1, overnight: 2}
  delegate :processing_fee, to: :price_calculator

  def self.for(user:)
    ShoppingCart.find_or_create_by(user_id: user.id)
  end

  def price_calculator
    @price_calculator ||= PriceCalculator.new(tickets, discount_code, shipping_method.to_s, address: address, user: user, tax_id: "cart_#{id}")
  end

  def tickets
    @tickets ||= user.tickets_in_cart
  end

  def events
    tickets.map(&:event).uniq.sort_by(&:name)
  end

  def tickets_by_performance
    tickets.group_by{|ticket| ticket.performance.id}
  end

  def performance_count
    tickets_by_performance.each_pair.each_with_object({}) do |pair, result|
      result[pair.first] = pair.last.size
    end
  end

  def performances_for(event)
    tickets.map(&:performance).select{|performance| performance.event == event}
      .uniq.sort_by(&:start_time)
  end

  def subtotal_for(performance)
    tickets_by_performance[performance.id].map{|ticket| ticket.price.to_i}.sum
  end

  def total_cost
    price_calculator.total_price
  end

  def item_attribute
    :ticket_ids
  end

  def item_ids
    tickets.map(&:id)
  end
end
