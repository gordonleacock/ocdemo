# Valkyrie Demo

This is a simple app created to demonstrate working with [Valkyrie](https://github.com/samvera-labs/valkyrie).

## Requirements
* Ruby 2.4.x
* PostgreSQL 9.x or later (on MacOS: `brew install postgres`)

## Setup
* `git clone https://github.com/escowles/vdemo`
* `cd vdemo`
* `bundle install`
* Edit `config/database.yml` to match local database settings, if needed
* `bundle exec rake db:create:all`
* `bundle exec rake db:migrate`
* `bundle exec rake db:migrate RAILS_ENV=test`

## Run the app
* Console: `bundle exec rails c`
* Webapp: `bundle exec rails s`
* Tests: `bundle exec rspec`

## Usage
* See the [Demo](https://github.com/escowles/vdemo/wiki/Demo)


## License
Valkyrie is available under [the Apache 2.0 license](LICENSE).


## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/escowles/vdemo/
