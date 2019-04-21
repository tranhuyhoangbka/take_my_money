Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
raise "Missing Stripe API Key" unless Stripe.api_key
