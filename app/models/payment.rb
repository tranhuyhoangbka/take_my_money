# == Schema Information
#
# Table name: payments
#
#  created_at     :datetime         not null
#  full_response  :json
#  id             :bigint(8)        not null, primary key
#  payment_method :string
#  price          :integer
#  reference      :string
#  response_id    :string
#  status         :integer
#  updated_at     :datetime         not null
#  user_id        :bigint(8)
#
# Indexes
#
#  index_payments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Payment < ApplicationRecord
  # acts_as_paranoid
  include HasReference

  belongs_to :user, optional: true
  has_many :payment_line_items, dependent: :destroy
  has_many :tickets, through: :payment_line_items, source_type: "Ticket", source: "buyable"

  enum status: {created: 0, succeeded: 1, pending: 2}

  def total_cost
    tickets.map(&:price).sum
  end

  def create_line_items(tickets)
    tickets.each do |ticket|
      payment_line_items.create!(buyable: ticket, price: ticket.price)
    end
  end
end
