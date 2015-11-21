require 'spec_helper'

describe Fyber::Offer do
  let(:valid_params) do
    { uid: 'player1', pub0: 'campaign2', page: '1' }
  end

  describe 'get offers' do
    valid_offers_response
    subject{ Fyber::Offer.new(valid_params) }

    it do
      lambda{
        get
        expect(a_request(:get, /#{Fyber::Offer.URL_API}/)).to have_been_made
      }
    end

    it { expect(subject.get).not_to be_empty }
  end

  describe 'get error from offers endpoint' do
    offers_response_with_error
    
    it do
      expect{ Fyber::Offer.new(valid_params).get }.to raise_error(Fyber::OfferRequestError)
    end
  end
end