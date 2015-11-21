module Macros
  def valid_offers_response
    mock_offers_request('offers.json')
  end

  def no_offers_response
    mock_offers_request('no_offers.json')
  end

  def offers_response_with_error
    mock_offers_request('offers_page_error.json', 400)
  end

  def fake_offers_response
    before do
      stub_request(:get, /#{Fyber::Offer::API_URL}/).
        to_return(body: '', status: 200, headers: { 'X-Sponsorpay-Response-Signature' => 'wrongsignature' })
    end
  end

  def mock_offers_request(json_filename, status = 200)
    before do
      with = (File.read(File.join(Sinatra::Application.root, 'spec', 'fixtures', json_filename)))
      stub_request(:get, /#{Fyber::Offer::API_URL}/).
        to_return(body: with, status: status, headers: 
          { 'X-Sponsorpay-Response-Signature' => Digest::SHA1.hexdigest("#{with}#{Fyber::Offer.instance_variable_get(:@config)[:api_key]}") }
        )
    end
  end
end