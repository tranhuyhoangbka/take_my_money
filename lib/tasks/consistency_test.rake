namespace :snow_globe do

  task check_consistency: :environment do
    inconsistent = Payment.all.reject do |payment|
      TicketPaymentConsistency.new(payment).consistent?
    end
    if inconsistent.empty?
      # ConsistencyMailer.all_is_well.deliver
    else
      # ConsistencyMailer.inconsistencies_detected(inconsistent).deliver
    end
  end

end
