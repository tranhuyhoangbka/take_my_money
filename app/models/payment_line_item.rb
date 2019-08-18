# == Schema Information
#
# Table name: payment_line_items
#
#  administrator_id      :bigint(8)
#  buyable_id            :bigint(8)
#  buyable_type          :string
#  created_at            :datetime         not null
#  id                    :bigint(8)        not null, primary key
#  original_line_item_id :bigint(8)
#  payment_id            :bigint(8)
#  price                 :float
#  refund_status         :integer          default(NULL)
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_payment_line_items_on_administrator_id             (administrator_id)
#  index_payment_line_items_on_buyable_type_and_buyable_id  (buyable_type,buyable_id)
#  index_payment_line_items_on_original_line_item_id        (original_line_item_id)
#  index_payment_line_items_on_payment_id                   (payment_id)
#
# Foreign Keys
#
#  fk_rails_...  (payment_id => payments.id)
#

class PaymentLineItem < ApplicationRecord
  # acts_as_paranoid

  belongs_to :payment
  belongs_to :buyable, polymorphic: true

  has_many :refunds, class_name: "PaymentLineItem",
    foreign_key: "original_line_item_id"
  belongs_to :original_line_item, class_name: "PaymentLineItem"

  enum refund_status: {no_refund: 1, refund_pending: 2, refunded: 3}

  delegate :event, to: :buyable, allow_nil: true
  delegate :performance, to: :buyable, allow_nil: true
  # delegate :name, :event, to: :performance, allow_nil: true
  delegate :id, to: :event, prefix: true, allow_nil: true

  def generate_refund_payment(admin:, amount_cents:, refund_payment: nil)
    refund_payment ||= Payment.create!(
      user_id: payment.user_id, price: -amount_cents,
      status: "refund_pending", payment_method: payment.payment_method,
      original_payment_id: payment.id, administrator: admin,
      reference: Payment.generate_reference)

    PaymentLineItem.create!(
      buyable: buyable, price: -price,
      refund_status: "refund_pending", original_line_item_id: id,
      administrator_id: admin.id, payment: refund_payment)
  end

  def original_payment
    original_line_item&.payment
  end

  def tickets
    [buyable]
  end
end
