require 'rack/test'
require 'capybara/rspec'
require_relative '../pastebit'

# Add the Rack test methods to all specs
RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

# Setup Capybara
Capybara.app = PasteBit
