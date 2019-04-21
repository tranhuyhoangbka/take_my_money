# == Schema Information
#
# Table name: payment_line_items
#
#  buyable_id   :bigint(8)
#  buyable_type :string
#  created_at   :datetime         not null
#  id           :bigint(8)        not null, primary key
#  payment_id   :bigint(8)
#  price        :float
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_payment_line_items_on_buyable_type_and_buyable_id  (buyable_type,buyable_id)
#  index_payment_line_items_on_payment_id                   (payment_id)
#
# Foreign Keys
#
#  fk_rails_...  (payment_id => payments.id)
#

FactoryGirl.define do
  factory :payment_line_item do
    payment nil
    buyable nil
    price 1.5
  end
end