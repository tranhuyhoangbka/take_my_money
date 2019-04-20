require "sidekiq/web"

sidekiq_username = ENV.fetch("SIDEKIQ_WEB_USERNAME"){"username"}
sidekiq_password = ENV.fetch("SIDEKIQ_WEB_PASSWORD"){"pass"}

Sidekiq::Web.app_url = "/"
Sidekiq::Web.use(Rack::Auth::Basic, "Application") do |username, password|
  username == sidekiq_username &&
    ActiveSupport::SecurityUtils.secure_compare(password, sidekiq_password)
end
