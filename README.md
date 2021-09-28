# OmniAuth Smaregi

Smaregi OAuth2 Strategy for OmniAuth.

Read the Smaregi API documentation for more details: https://developers.smaregi.jp/

## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-smaregi'
```

Then `bundle install`.

## Usage

`OmniAuth::Strategies::Smaregi` is simply a Rack middleware. Read the OmniAuth docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :smaregi, ENV['SMAREGI_CLIENT_ID'], ENV['SMAREGI_CLIENT_SECRET'], scope: 'openapi'
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
