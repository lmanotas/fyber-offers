require 'json'
require 'uri'
require 'digest'
require 'net/http'

module Fyber
  class OfferRequestError < StandardError;end
  class Offer

    API_URL     = 'http://api.sponsorpay.com/feed/v1/offers.json'

    API_KEY = 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'

    PARAMS      = {
      uid:         '',
      pub0:        '',
      pages:       1,
      appid:       '157',
      device_id:   '2b6f0cc904d137be2e1730235f5664094b83',
      ip:          '109.235.143.113',
      locale:      'de',
      offer_types: '112',
      timestamp:   nil
    }

    def initialize(params = {})
      @params = PARAMS.merge(params)
    end

    def get
      uri = URI(API_URL)
      uri.query = query_params

      @response = Net::HTTP.get_response(uri)
      
      process_response
    end

    private

      def hashkey
        sorted_params = @params.sort.to_h
        s_params      = stringify_params( sorted_params )

        return Digest::SHA1.hexdigest "#{s_params}&#{API_KEY}"
      end

      def process_response
        if @response.is_a?(Net::HTTPSuccess)
          JSON.parse(@response.body)["offers"]
        else
          raise_response_error
        end
      end

      def raise_response_error
        raise Fyber::OfferRequestError.new(JSON.parse(@response.body)["message"])
      end

      def stringify_params(params)
        params.collect{|k,v| "#{k}=#{v}"}.join('&')
      end

      def query_params
        @params[:timestamp] = Time.now.getutc.to_i
        URI.escape( stringify_params( @params.merge( { hashkey: hashkey } ) ) )
      end

  end
end