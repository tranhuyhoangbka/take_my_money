# == Schema Information
#
# Table name: addresses
#
#  address_1  :string
#  address_2  :string
#  city       :string
#  created_at :datetime         not null
#  id         :bigint(8)        not null, primary key
#  state      :string
#  updated_at :datetime         not null
#  zip        :string
#

class Address < ApplicationRecord
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  def all_fields
    [address_1, address_2, city, state, zip].compact.join(", ")
  end
end
