# == Schema Information
#
# Table name: events
#
#  created_at  :datetime         not null
#  deleted_at  :datetime
#  description :text
#  id          :bigint(8)        not null, primary key
#  image_url   :string
#  name        :string
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_events_on_deleted_at  (deleted_at)
#

class Event < ApplicationRecord
  acts_as_paranoid
  has_many :performances, dependent: :destroy
end
