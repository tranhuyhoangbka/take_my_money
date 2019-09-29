# == Schema Information
#
# Table name: addresses
#
#  address_1  :string
#  address_2  :string
#  city       :string
#  created_at :datetime         not null
#  id         :bigint(8)        not null, primary key
#  state      :string
#  updated_at :datetime         not null
#  zip        :string
#

FactoryGirl.define do
  factory :address do
    address_1 "MyString"
    address_2 "MyString"
    city "MyString"
    state "MyString"
    zip "MyString"
  end
end
