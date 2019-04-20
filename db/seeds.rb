puts "Create 10 users..."

10.times{|i| User.create(email: "user#{i}@gmail.com", password: "A12345678", password_confirmation: "A12345678")}

puts "Create 30 events..."

30.times{|i| Event.create name: Faker::Music.album, description: Faker::Lorem.paragraph}

puts "Create 3 performances for each of event ..."

Event.find_each do |event|
  event.performances.create start_time: Faker::Time.between(15.days.ago, 3.days.ago, :all), end_time: Faker::Time.between(2.days.ago, 2.years.from_now, :all)
  event.performances.create start_time: Faker::Time.between(15.days.ago, 3.days.ago, :all), end_time: Faker::Time.between(1.days.ago, 2.years.from_now, :all)
  event.performances.create start_time: Faker::Time.between(15.days.ago, 3.days.ago, :all), end_time: Faker::Time.between(1.days.ago, 2.years.from_now, :all)
end

puts "Create 15 tickets for each of performance ..."

Performance.find_each do |performance|
  puts "..."
  15.times{|i| performance.tickets.create status: "unsole", access: "general", price: Faker::Number.decimal(2, 2)}
end
