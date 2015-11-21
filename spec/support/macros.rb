module Macros
  def valid_offers_response
    preparing_api_url
    let(:valid_response){ (File.read(File.join(Sinatra::Application.root, 'spec', 'fixtures', 'offers.json'))) }

    before do
      stub_request(:get, api_url).to_return(body: valid_response)
    end
  end

  def no_offers_response
    preparing_api_url
    let(:no_offers_body){ (File.read(File.join(Sinatra::Application.root, 'spec', 'fixtures', 'no_offers.json'))) }

    before do
      stub_request(:get, api_url).to_return(body: no_offers_body)
    end
  end

  def offers_response_with_error
    preparing_api_url
    let(:error_response){ (File.read(File.join(Sinatra::Application.root, 'spec', 'fixtures', 'offers_page_error.json'))) }
    let(:error_message){ error_response["message"] }

    before do
      stub_request(:get, api_url).to_return(body: error_response, status: 400)
    end
  end

  def preparing_api_url
    let(:api_url){ Fyber::Offer::API_URL }
  end
end