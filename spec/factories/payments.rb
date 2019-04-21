# == Schema Information
#
# Table name: payments
#
#  created_at     :datetime         not null
#  full_response  :json
#  id             :bigint(8)        not null, primary key
#  payment_method :string
#  price          :integer
#  reference      :string
#  response_id    :string
#  status         :integer
#  updated_at     :datetime         not null
#  user_id        :bigint(8)
#
# Indexes
#
#  index_payments_on_user_id  (user_id)
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
