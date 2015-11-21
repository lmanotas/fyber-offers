require 'spec_helper'

describe Fyber::Offer do
  let(:valid_params) do
    { uid: 'player1', pub0: 'campaign2', page: '1' }
  end
  subject{ Fyber::Offer.new(valid_params) }

  describe 'get offers' do
    valid_offers_response

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
    
    it { expect{ subject.get }.to raise_error(Fyber::OfferRequestError) }
  end

  describe 'fake response, should raise error' do
    fake_offers_response

    it { expect{ subject.get }.to raise_error(Fyber::FakeOfferResponse) }
  end
end