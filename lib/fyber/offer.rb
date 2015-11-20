module Fyber
  class Offer

    API_URL = 'http://api.fyber.com/feed/v1/offers.json'

    class << self
      def get
        uri = URI(API_URL)
        Net::HTTP.get_response(uri)
      end
    end

  end
end