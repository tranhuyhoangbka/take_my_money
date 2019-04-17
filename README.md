# take_my_money

This is a Rails 5 app.

## Documentation

This README describes the purpose of this repository and how to set up a development environment. Other sources of documentation are as follows:

* UI and API designs are in `doc/`
* Server setup instructions are in `PROVISIONING.md`
* Staging and production deployment instructions are in `DEPLOYMENT.md`

## Prerequisites

This project requires:

* Ruby 2.6.0, preferably managed using [rbenv][]
* Chromedriver for Capybara testing
* PostgreSQL must be installed and accepting connections
* [Redis][] must be installed and running on localhost with the default port

On a Mac, you can obtain all of the above packages using [Homebrew][].

If you need help setting up a Ruby development environment, check out this [Rails OS X Setup Guide](https://mattbrictson.com/rails-osx-setup-guide).

## Getting started

### bin/setup

Run the `bin/setup` script. This script will:

* Check you have the required Ruby version
* Install gems using Bundler
* Create local copies of `.env` and `database.yml`
* Create, migrate, and seed the database

### Run it!

1. Run `bin/rake test` to make sure everything works.
2. Run `bin/rake test:system` to run system (capybara) tests.
3. Run `bin/rails s` and `bin/sidekiq` to start the app and Sidekiq; alternatively, start both at once with `heroku local`.


[rbenv]:https://github.com/sstephenson/rbenv
[redis]:http://redis.io
[Homebrew]:http://brew.sh
