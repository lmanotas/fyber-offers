module Fyber
  class OfferRequestError < StandardError;end

  class Offer

    API_URL = 'http://api.fyber.com/feed/v1/offers.json'

    class << self
      def get
        uri = URI(API_URL)
        res = Net::HTTP.get_response(uri)
        if res.is_a?(Net::HTTPSuccess)
          JSON.parse(res.body)["offers"]
        else
          raise Fyber::OfferRequestError.new(res.body["message"])
        end
      end
    end

  end
end