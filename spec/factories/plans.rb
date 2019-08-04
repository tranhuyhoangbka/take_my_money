# == Schema Information
#
# Table name: plans
#
#  created_at      :datetime         not null
#  description     :text
#  id              :bigint(8)        not null, primary key
#  interval        :integer
#  interval_count  :integer
#  name            :string
#  price           :string
#  remote_id       :string
#  status          :integer
#  ticket_category :string
#  tickets_allowed :integer
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :plan do
    remote_id "MyString"
    name "MyString"
    price "MyString"
    interval 1
    interval_count 1
    tickets_allowed 1
    ticket_category "MyString"
    status 1
    description "MyText"
  end
end
