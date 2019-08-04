# == Schema Information
#
# Table name: subscriptions
#
#  created_at     :datetime         not null
#  end_date       :date
#  id             :bigint(8)        not null, primary key
#  payment_method :string
#  plan_id        :bigint(8)
#  remote_id      :string
#  start_date     :date
#  status         :integer
#  updated_at     :datetime         not null
#  user_id        :bigint(8)
#
# Indexes
#
#  index_subscriptions_on_plan_id  (plan_id)
#  index_subscriptions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryGirl.define do
  factory :subscription do
    user nil
    plan nil
    start_date "2019-07-28"
    end_date "2019-07-28"
    status 1
    payment_method "MyString"
    remote_id "MyString"
  end
end
