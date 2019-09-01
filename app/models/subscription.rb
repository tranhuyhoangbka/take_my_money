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

class Subscription < ApplicationRecord
  has_paper_trail
  has_one :payment_line_item, as: :buyable
  belongs_to :user
  belongs_to :plan

  delegate :remote_plan_id, to: :plan, allow_nil: true

  enum status: {waiting: 1, pending_initial_payment: 2, active: 3, canceled: 4}

  def make_stripe_payment(stripe_customer)
    update!(payment_method: :stripe, status: :pending_initial_payment,
      remote_id: stripe_customer.find_subscription_for(plan)&.id)
  end

  def currently_active?
    active? && (end_date > Date.current)
  end

  def update_end_date
    self.update end_date: (Time.now + eval("#{plan.interval_count}.#{plan.interval}")).to_date
  end
end
