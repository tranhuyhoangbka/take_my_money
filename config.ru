if defined?(Unicorn)
  require "unicorn/worker_killer"
  use Unicorn::WorkerKiller::MaxRequests, 3072, 4096
end

# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

use Rack::CanonicalHost, ENV["HOSTNAME"] if ENV["HOSTNAME"].present?
run Rails.application
