require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'rack/test'

Sinatra::Application.environment = :test

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.app = Sinatra::Application