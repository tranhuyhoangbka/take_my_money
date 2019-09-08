class DailyRevenue < SimpleDelegator
  include Reportable

  def self.find_collection
    DayRevenue.all.to_a.push(Payment.recent_revenues).flatten.map do |r|
      DailyRevenue.new r
    end
  end

  def initialize day_revenue
    super(day_revenue)
  end

  columns do
    column :id
    column :day
    column :price
    column :discounts
    column :ticket_count
  end
end
