class BuildDailyRevenueJob < ApplicationJob
  queue_as :default

  def perform
    ActiveRecord::Base.transaction do
      DayRevenue.destroy_all
      revenues = ActiveRecord::Base.connection.select_all(%{
        SELECT DATE(created_at) as day, sum(discount) as discounts, sum(price) as price
        FROM payments
        WHERE status = 1
        GROUP BY DATE(created_at)
        HAVING DATE(created_at) < '#{1.day.ago.to_date}'
      }).to_a
      DayRevenue.create! revenues

      DayRevenue.find_each do |day_revenue|
        ticket_count = PaymentLineItem.joins(:ticket).where.not(tickets: {status: "refunded"}).where("DATE(payment_line_items.created_at) = ?", day_revenue.day).count
        day_revenue.update ticket_count: ticket_count
      end
    end
  end
end
