require 'json'
require 'uri'
require 'digest'
require 'net/http'
require 'yaml'

module Fyber
  class OfferRequestError < StandardError;end
  class FakeOfferResponse < StandardError;end
  class Offer

    API_URL     = 'http://api.sponsorpay.com/feed/v1/offers.json'

    def self.load!(config)
      @config ||= config
    end

    def config
      self.class.instance_variable_get(:@config)
    end

    def initialize(params = {})
      @params = config[:default_params].merge(params)
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

        return Digest::SHA1.hexdigest "#{s_params}&#{config[:api_key]}"
      end

      def process_response
        if @response.is_a?(Net::HTTPSuccess)
          check_response_signature!
          JSON.parse(@response.body)["offers"]
        else
          raise_response_error
        end
      end

      def check_response_signature!
        resp_signature = Digest::SHA1.hexdigest("#{@response.body}#{config[:api_key]}")
        raise Fyber::FakeOfferResponse.new('Its a Fake Response!') unless resp_signature == @response.header["X-Sponsorpay-Response-Signature"]
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