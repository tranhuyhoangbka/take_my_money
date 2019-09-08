# == Schema Information
#
# Table name: day_revenues
#
#  created_at   :datetime         not null
#  day          :date
#  discounts    :integer
#  id           :bigint(8)        not null, primary key
#  price        :integer
#  ticket_count :integer
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :day_revenue do
    day "2019-09-08"
    ticket_count 1
    price 1
    discounts 1
  end
end
