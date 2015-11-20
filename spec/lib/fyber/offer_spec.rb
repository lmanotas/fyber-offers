require 'spec_helper'

describe Fyber::Offer do
  let(:valid_response){ (File.read(File.join(Sinatra::Application.root, 'spec', 'fixtures', 'offers.json'))) }
  let(:api_url){ Fyber::Offer::API_URL }

  describe 'get offers' do
    subject{ Fyber::Offer.get() }

    before do
      stub_request(:get, api_url).to_return(body: valid_response)
    end

    it do
      subject
      expect(a_request(:get, api_url)).to have_been_made
    end

    it do
      expect(subject).not_to be_empty
    end
  end

  describe 'get error from offers endpoint' do
    let(:error_response){ (File.read(File.join(Sinatra::Application.root, 'spec', 'fixtures', 'offers_page_error.json'))) }
    let(:error_message){ error_response["message"] }
    it do
      stub_request(:get, api_url).to_return(body: error_response, status: 400)
      expect{ Fyber::Offer.get() }.to raise_error(Fyber::OfferRequestError, error_message)
    end
  end
end