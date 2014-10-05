require 'rspec'
require 'capybara/rspec'
require 'fakeredis/rspec'

require_relative '../app.rb'
require_relative 'navigation'

include Ronin::Test::Navigation

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.app = Ronin::Website
