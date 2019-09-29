# == Schema Information
#
# Table name: affiliates
#
#  country             :string
#  created_at          :datetime         not null
#  id                  :bigint(8)        not null, primary key
#  name                :string
#  stripe_id           :string
#  tag                 :string
#  updated_at          :datetime         not null
#  user_id             :integer
#  verification_needed :json
#

class Affiliate < ApplicationRecord
  include HasReference

  belongs_to :user

  def self.generate_tag
    generate_reference(length: 5, attribute: :tag)
  end
end
