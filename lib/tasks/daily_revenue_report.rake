namespace :daily_revenue_report do
  task update: :environment do
    BuildDailyRevenueJob.perform_now
  end
end