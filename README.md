# Valkyrie Demo

This is a simple app created to demonstrate working with [Valkyrie](https://github.com/samvera-labs/valkyrie).

## Requirements
* Ruby 2.4.x
* PostgreSQL 9.x or later
  On MacOS: `brew install postgres`

## Setup
* `git clone https://github.com/escowles/vdemo`
* `cd vdemo`
* `bundle install`
* Edit `config/database.yml` to match local database settings, if needed
* `bundle exec rake db:create:all`
* `bundle exec rake db:migrate:all`
* Console: `bundle exec rails c`
* Webapp: `bundle exec rails s`
* Tests: `bundle exec rspec`

## Usage
* See the [Demo](https://github.com/escowles/vdemo/wiki/Demo)
