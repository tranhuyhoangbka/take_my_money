# == Schema Information
#
# Table name: payment_line_items
#
#  administrator_id      :bigint(8)
#  buyable_id            :bigint(8)
#  buyable_type          :string
#  created_at            :datetime         not null
#  id                    :bigint(8)        not null, primary key
#  original_line_item_id :bigint(8)
#  payment_id            :bigint(8)
#  price                 :float
#  refund_status         :integer          default(NULL)
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_payment_line_items_on_administrator_id             (administrator_id)
#  index_payment_line_items_on_buyable_type_and_buyable_id  (buyable_type,buyable_id)
#  index_payment_line_items_on_original_line_item_id        (original_line_item_id)
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
