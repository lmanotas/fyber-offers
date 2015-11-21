require 'spec_helper'
require 'rack/test'

describe 'Use Fyber::Offer to fetch offers from API', type: :controller do
  valid_offers_response

  def app
    Sinatra::Application
  end

  it do
    lambda{
      post '/'
      expect(Fyber::Offer).to receive(:get)
    }
  end
end