require 'rack/test'
require 'capybara/rspec'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
