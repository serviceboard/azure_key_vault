# AzureKV

The Azure Key Vault REST APIs are used to manage secrets in Azure Key Vault. This gem provides a simple interface to the REST APIs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'azure_kv'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install azure_kv

## Usage

```ruby
client = AzureKV::Client.new
client.secret.retrieve(name: 'my_secret')
client.secret.create(name: 'my_secret', value: 'my_secret_value', content_type: 'token')
client.secret.update(name: 'my_secret', value: 'my_secret_value')
client.secret.delete(name: 'my_secret')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).