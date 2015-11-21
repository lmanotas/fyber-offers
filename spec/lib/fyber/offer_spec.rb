require 'spec_helper'

describe Fyber::Offer do
  describe 'get offers' do
    valid_offers_response
    subject{ Fyber::Offer.get() }

    it do
      subject
      expect(a_request(:get, api_url)).to have_been_made
    end

    it do
      expect(subject).not_to be_empty
    end
  end

  describe 'get error from offers endpoint' do
    offers_response_with_error
    
    it do
      expect{ Fyber::Offer.get() }.to raise_error(Fyber::OfferRequestError, error_message)
    end
  end
end