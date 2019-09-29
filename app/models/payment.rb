# == Schema Information
#
# Table name: payments
#
#  administrator_id           :bigint(8)
#  affiliate_id               :integer
#  affiliate_payment_cents    :integer          default(0), not null
#  affiliate_payment_currency :string           default("USD"), not null
#  billing_address_id         :integer
#  created_at                 :datetime         not null
#  discount                   :integer
#  discount_code_id           :bigint(8)
#  full_response              :json
#  id                         :bigint(8)        not null, primary key
#  original_payment_id        :bigint(8)
#  partials                   :json
#  payment_method             :string
#  price                      :integer
#  reference                  :string
#  response_id                :string
#  shipping_address_id        :integer
#  shipping_method            :integer          default(0)
#  status                     :integer
#  updated_at                 :datetime         not null
#  user_id                    :bigint(8)
#
# Indexes
#
#  index_payments_on_administrator_id     (administrator_id)
#  index_payments_on_discount_code_id     (discount_code_id)
#  index_payments_on_original_payment_id  (original_payment_id)
#  index_payments_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Payment < ApplicationRecord
  # acts_as_paranoid
  include HasReference
  has_paper_trail

  belongs_to :user, optional: true
  has_many :payment_line_items, dependent: :destroy
  has_many :tickets, through: :payment_line_items, source_type: "Ticket", source: "buyable"
  belongs_to :administrator, class_name: "User"
  has_many :refunds, class_name: "Payment", foreign_key: "original_payment_id"
  belongs_to :original_payment, class_name: "Payment"
  belongs_to :discount_code
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :affiliate, optional: true

  enum status: {created: 0, succeeded: 1, pending: 2, failed: 3, refund_pending: 4, refunded: 5}

  def date
    created_at.to_s(:sql)
  end

  def total_cost
    tickets.map(&:price).sum
  end

  def create_line_items(tickets)
    tickets.each do |ticket|
      payment_line_items.create!(buyable: ticket, price: ticket.price)
    end
  end

  def sorted_ticket_ids
    tickets.map(&:id).sort
  end

  def generate_refund_payment(amount_cents:, admin:)
    refund_payment = Payment.create!(
      user_id: user_id, price: -amount_cents, status: "refund_pending",
      payment_method: payment_method, original_payment_id: id,
      administrator: admin, reference: Payment.generate_reference)

    payment_line_items.each do |line_item|
      line_item.generate_refund_payment(
        admin: admin,
        amount_cents: amount_cents,
        refund_payment: refund_payment)
    end
    refund_payment
  end

  def payment
    self
  end

  def maximum_available_refund
    price + refunds.map(&:price).sum
  end

  def can_refund?(price)
    price <= maximum_available_refund
  end

  def refund?
    price.negative?
  end

  class << self
    def recent_revenues
      revenues = ActiveRecord::Base.connection.select_all(%{
        SELECT DATE(created_at) as day, sum(discount) as discounts, sum(price) as price
        FROM payments
        WHERE status = 1
        GROUP BY DATE(created_at)
        HAVING DATE(created_at) >= '#{1.day.ago.to_date}'
      }).to_a
      revenues.map do |r|
        ticket_count = PaymentLineItem.joins(:ticket).where.not(tickets: {status: "refunded"}).where("DATE(payment_line_items.created_at) = ?", r["day"]).count
        r.merge! ticket_count: ticket_count
        DayRevenue.new r
      end
    end
  end
end
