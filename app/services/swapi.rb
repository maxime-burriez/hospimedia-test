module Swapi
  module V1
    class Client
      API_ENDPOINT = 'https://swapi.dev/api/'.freeze

      def films
        request(
          http_method: :get,
          endpoint: "films"
        )["results"]
      end

      def characters_by_film_ordered_by_mass(film)
        (film["characters"].map do |character_url|
          request(
            http_method: :get,
            endpoint: character_url
          )
        end).sort_by { |character| character["mass"].to_i }
      end      

      private

      def client
        @_client ||= Faraday.new(API_ENDPOINT) do |client|
          client.request :url_encoded
          client.adapter Faraday.default_adapter
        end
      end

      def request(http_method:, endpoint:, params: {})
        response = client.public_send(http_method, endpoint, params)
        Oj.load(response.body)
      end
    end
  end
end