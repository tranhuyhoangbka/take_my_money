Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
Stripe.log_level = Stripe::LEVEL_DEBUG
raise "Missing Stripe API Key" unless Stripe.api_key
STRIPE_JS_HOST = "https://js.stripe.com".freeze unless defined?(STRIPE_JS_HOST)

# load stripe.js if in production environment.
STRIPE_JS_FILE = Rails.env.development? ? "stripe-debug.js" : ""
