# frozen_string_literal: true

require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Smaregi < OmniAuth::Strategies::OAuth2
      option :name, "smaregi"

      option :client_options, {
        site: "https://id.smaregi.dev",
        authorize_url: "https://id.smaregi.dev/authorize",
        token_url: "https://id.smaregi.dev/authorize/token"
      }

      option :authorize_options, [:scope]

      uid { raw_info["contract"]["id"] }

      info { raw_info }

      def raw_info
        @raw_info ||= access_token.get("/userinfo").parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end

      def build_access_token
        client.auth_code.get_token(
          request.params["code"],
          {
            redirect_uri: callback_url
          }.merge(token_params.to_hash(symbolize_keys: true)), deep_symbolize(options.auth_token_params)
        )
      end
    end
  end
end
