require 'sinatra'
require './lib/fyber/offer'

set :haml, format: :html5
set :root, File.dirname(__FILE__)

get '/' do
  haml :index
end

post '/' do
  begin
    @offers = Fyber::Offer.get
    haml :offers
  rescue Fyber::OfferRequestError => e
    @error = e.message
    haml :error_page
  end
end

not_found do
  @error = "Page Not Found"
  haml :error_page
end