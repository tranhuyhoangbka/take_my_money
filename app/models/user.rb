# == Schema Information
#
# Table name: users
#
#  authy_id               :string
#  created_at             :datetime         not null
#  deleted_at             :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  id                     :bigint(8)        not null, primary key
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
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
  has_paper_trail ignore: %i(sign_in_count current_sign_in_at last_sign_in_at)
  acts_as_paranoid
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tickets, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_one :shopping_cart
  has_many :affiliates

  attr_accessor :cellphone_number

  enum role: {user: 0, vip: 1, admin: 2}

  def tickets_in_cart
    tickets.waiting.all.to_a
  end

  def subscriptions_in_cart
    subscriptions.waiting.all.to_a
  end
end
