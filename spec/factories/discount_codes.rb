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

FactoryGirl.define do
  factory :discount_code do
    code "MyString"
    percentage 1
    description "MyText"
    minimum_amount 1
    maximum_discount 1
    max_uses 1
  end
end
