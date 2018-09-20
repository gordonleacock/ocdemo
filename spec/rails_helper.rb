ENV["RACK_ENV"] = "test"
require "simplecov"
require "coveralls"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
)
SimpleCov.start "rails"

require File.expand_path("../../config/environment", __FILE__)
Dir[Rails.root.join("spec", "support", "**", "*.rb")].sort.each { |file| require file }

require "rspec/rails"

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
end

ActiveRecord::Migration.maintain_test_schema!
