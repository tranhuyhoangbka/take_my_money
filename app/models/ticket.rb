# == Schema Information
#
# Table name: tickets
#
#  access         :integer
#  created_at     :datetime         not null
#  deleted_at     :datetime
#  id             :bigint(8)        not null, primary key
#  performance_id :bigint(8)
#  price          :float
#  status         :integer
#  updated_at     :datetime         not null
#  user_id        :bigint(8)
#
# Indexes
#
#  index_tickets_on_deleted_at      (deleted_at)
#  index_tickets_on_performance_id  (performance_id)
#  index_tickets_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (performance_id => performances.id)
#  fk_rails_...  (user_id => users.id)
#

class Ticket < ApplicationRecord
  acts_as_paranoid
  belongs_to :user, optional: true
  belongs_to :performance
  has_one :event, through: :performance
  has_one :payment_line_item, as: :buyable

  enum status: {unsole: 0, waiting: 1, purchased: 2}
  enum access: {general: 0}

  def place_in_cart_for(user)
    update(status: :waiting, user: user)
  end
end
