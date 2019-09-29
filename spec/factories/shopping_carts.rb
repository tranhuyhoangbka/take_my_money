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

FactoryGirl.define do
  factory :shopping_cart do
    user nil
    address nil
    shipping_method 1
    discount_code nil
  end
end
