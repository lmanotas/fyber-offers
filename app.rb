require 'sinatra'
require './lib/fyber/offer'

set :haml, format: :html5
set :root, File.dirname(__FILE__)

get '/' do
  haml :index
end

not_found do
  "Page Not Found"
end