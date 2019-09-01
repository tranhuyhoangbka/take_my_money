# == Schema Information
#
# Table name: performances
#
#  created_at :datetime         not null
#  deleted_at :datetime
#  end_time   :datetime
#  event_id   :bigint(8)
#  id         :bigint(8)        not null, primary key
#  start_time :datetime
#  updated_at :datetime         not null
#
# Indexes
#
#  index_performances_on_deleted_at  (deleted_at)
#  index_performances_on_event_id    (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#

class Performance < ApplicationRecord
  acts_as_paranoid
  has_paper_trail
  belongs_to :event
  has_many :tickets, dependent: :destroy

  def unsole_tickets(count)
    tickets.where(status: "unsole").limit(count)
  end
end
