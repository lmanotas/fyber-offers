require 'sinatra'
require './lib/fyber/offer'

set :haml, format: :html5
set :root, File.dirname(__FILE__)

Fyber::Offer.load!(YAML::load(File.open(File.join(Sinatra::Application.root, 'config', 'fyber_api.yml'))))

get '/' do
  haml :index
end

post '/' do  
  begin
    @offers = Fyber::Offer.new({uid: params[:uid], page: params[:page], pub0: params[:pub0]}).get
    haml :offers
  rescue Fyber::OfferRequestError, Fyber::FakeOfferResponse => e
    @error = e.message
    haml :error_page
  end
end

not_found do
  @error = "Page Not Found"
  haml :error_page
end