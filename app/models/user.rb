# == Schema Information
#
# Table name: users
#
#  created_at             :datetime         not null
#  deleted_at             :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  id                     :bigint(8)        not null, primary key
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  stripe_id              :string
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_deleted_at            (deleted_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_paranoid
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tickets, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  def tickets_in_cart
    tickets.waiting.all.to_a
  end

  def subscriptions_in_cart
    subscriptions.waiting.all.to_a
  end
end
