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

class Plan < ApplicationRecord
  has_paper_trail
  enum status: {inactive: 0, active: 1}
  enum interval: {day: 0, week: 1, month: 2, year: 3}

  def remote_plan
    @remote_plan ||= Stripe::Plan.retrieve(remote_id)
  end

  def end_date_from(date = nil)
    date ||= Date.current
    interval_count.send(interval).from_now(date)
  end
end
