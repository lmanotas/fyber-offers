require 'sinatra'
require './lib/fyber/offer'

set :haml, :format => :html5

get '/' do
  haml :index
end

not_found do
  "Page Not Found"
end