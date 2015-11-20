require 'spec_helper'

describe Fyber::Offer do
  let(:valid_response){ JSON.parse(File.read('../spec/fixtures/offers.json')) }

  describe 'get offers' do
    it do
      Fyber::Offer.get()
      assert_requested :get, "http://api.fyber.com/feed/v1/offers.json"
    end
  end
end