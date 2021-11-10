# frozen_string_literal: true

require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Smaregi < OmniAuth::Strategies::OAuth2
      SANDBOX_SITE = "https://id.smaregi.dev"
      SANDBOX_AUTHORIZE_URL = "https://id.smaregi.dev/authorize"
      SANDBOX_TOKEN_URL = "https://id.smaregi.dev/authorize/token"
      option :name, "smaregi"

      option :client_options, {
        site: "https://id.smaregi.jp",
        authorize_url: "https://id.smaregi.jp/authorize",
        token_url: "https://id.smaregi.jp/authorize/token"
      }

      option :authorize_options, [:scope]

      option :sandbox, false

      uid { raw_info["contract"]["id"] }

      info { raw_info }

      def raw_info
        @raw_info ||= access_token.get("/userinfo").parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end

      def setup_phase
        if options.sandbox
          options.client_options[:site] = SANDBOX_SITE
          options.client_options[:authorize_url] = SANDBOX_AUTHORIZE_URL
          options.client_options[:token_url] = SANDBOX_TOKEN_URL
        end
        super
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
