namespace :snow_globe do
  task migrate_discounts: :environment do
    Payment.transaction do
      Payment.find_each do |payment|
        partials = {}
        if payment.discount&.positive?
          partials[:discount] = -payment.discount
        end
        partials[:tickets] = payment.tickets.map(&:price)
        payment.update partials: partials
      end
    end
  end
end