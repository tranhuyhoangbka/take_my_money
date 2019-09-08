# == Schema Information
#
# Table name: day_revenues
#
#  created_at   :datetime         not null
#  day          :date
#  discounts    :integer
#  id           :bigint(8)        not null, primary key
#  price        :integer
#  ticket_count :integer
#  updated_at   :datetime         not null
#

class DayRevenue < ApplicationRecord
end
