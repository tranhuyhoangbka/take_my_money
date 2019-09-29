# == Schema Information
#
# Table name: payments
#
#  administrator_id           :bigint(8)
#  affiliate_id               :integer
#  affiliate_payment_cents    :integer          default(0), not null
#  affiliate_payment_currency :string           default("USD"), not null
#  billing_address_id         :integer
#  created_at                 :datetime         not null
#  discount                   :integer
#  discount_code_id           :bigint(8)
#  full_response              :json
#  id                         :bigint(8)        not null, primary key
#  original_payment_id        :bigint(8)
#  partials                   :json
#  payment_method             :string
#  price                      :integer
#  reference                  :string
#  response_id                :string
#  shipping_address_id        :integer
#  shipping_method            :integer          default(0)
#  status                     :integer
#  updated_at                 :datetime         not null
#  user_id                    :bigint(8)
#
# Indexes
#
#  index_payments_on_administrator_id     (administrator_id)
#  index_payments_on_discount_code_id     (discount_code_id)
#  index_payments_on_original_payment_id  (original_payment_id)
#  index_payments_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryGirl.define do
  factory :payment do
    user nil
    price 1.5
    status 1
    reference "MyString"
    payment_method "MyString"
    response_id "MyString"
    full_response ""
  end
end
