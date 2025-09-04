module RapidApi
  class LatestStockPrice
    BASE_URL = 'https://latest-stock-price.p.rapidapi.com'.freeze
    AUTH_KEY = Rails.application.credentials.dig(:rapid_api, :api_key)
    HEADERS = { headers: {
      'Content-Type' => 'application/octet-stream',
      'X-RapidAPI-Key' => AUTH_KEY
    } }.freeze

    class << self
      def equities(symbols)
        return if symbols.nil?

        query = { query: { Symbols: symbols } }
        HTTParty.get("#{BASE_URL}/equities-enhanced", HEADERS.merge(query))
      end

      def equities_all
        HTTParty.get("#{BASE_URL}/equities", HEADERS)
      end
    end
  end
end
