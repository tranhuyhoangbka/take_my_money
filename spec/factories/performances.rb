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

FactoryGirl.define do
  factory :performance do
    event nil
    start_time "2019-04-20 18:34:21"
    end_time "2019-04-20 18:34:21"
  end
end
