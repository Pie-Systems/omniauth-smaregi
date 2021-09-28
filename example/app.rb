# frozen_string_literal: true

require "sinatra"
require "sinatra/reloader"

# configure sinatra
set :run, false
set :raise_errors, true
set :sessions, true

get "/" do
  content_type "text/html"

  <<-HTML
    <html>
      <body>
        <form action="/auth/smaregi" method="POST">
          <input type="hidden" name="authenticity_token" value='#{request.env["rack.session"]["csrf"]}'>
          <button type="submit">Connect to Smaregi</button>
        </form>
      </body>
    </html>
  HTML
end

get "/auth/:provider/callback" do
  content_type "application/json"
  MultiJson.encode(request.env)
end
