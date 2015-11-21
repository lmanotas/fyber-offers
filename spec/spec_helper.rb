require File.join(File.dirname(__FILE__), '..', 'app.rb')
require File.join(File.dirname(__FILE__), 'support', 'macros.rb')

require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'rack/test'
require 'webmock/rspec'

Sinatra::Application.environment = :test

RSpec.configure do |config|
  config.include Rack::Test::Methods, type: :controller
  config.include Capybara::DSL, type: :acceptance
  config.extend Macros
end

Capybara.app = Sinatra::Application