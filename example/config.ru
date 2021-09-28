# frozen_string_literal: true

require "bundler/setup"
require "omniauth-smaregi"
require "./app"

use Rack::Session::Cookie, secret: "omniauth-smaregi"

use OmniAuth::Builder do
  provider :smaregi, ENV["SMAREGI_CLIENT_ID"], ENV["SMAREGI_CLIENT_SECRET"], scope: "openid"
end

run Sinatra::Application
