# Grape::Throttling

[![Build Status](https://travis-ci.org/OuYangJinTing/grape-throttling.svg)](https://travis-ci.org/OuYangJinTing/grape-throttling)
[![Gem Version](https://badge.fury.io/rb/grape-throttling.svg)](https://badge.fury.io/rb/grape-throttling)
[![Maintainability](https://api.codeclimate.com/v1/badges/f200c46569aa627315f6/maintainability)](https://codeclimate.com/github/OuYangJinTing/grape-throttling/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/f200c46569aa627315f6/test_coverage)](https://codeclimate.com/github/OuYangJinTing/grape-throttling/test_coverage)

If your api through [`grape`](https://github.com/ruby-grape/grape) build, you can use `grape-throttling` limit api rate.

**Import:** `Grape::Throttling` depend on [`redis`](https://github.com/redis/redis), you must install [`redis`](https://github.com/redis/redis) first

- **Simple**. The you only need to call `use_throttle` in your api internal.
- **Throttle remind**. The response header include `X-RateLimit-Limit`, `X-Ratelimit-Used`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'grape-throttling'
```

And then execute:

```ruby
bundle install
```

Or install it yourself as:

```ruby
gem install grape-throttling
```

## Usage

```ruby
class Api < Grape::API
  use_throttle(max: 60, expire: 1.day, condition: proc { !current_user.is_admin? }, identity: proc { request.ip })
end
```

| Argument Key | Default               | Description                    |
| ------------ | --------------------- | ------------------------------ |
| `max`        | `60`                  | Maximum rate that can be used. |
| `expire`     | `1.day`               | Waiting time for reset rate.   |
| `condition`  | `proc { true }`       | Condition of enabled throttle. |
| `identity`   | `proc { request.ip }` | Used for throttle identity.    |

## Configure

```ruby
# Default configuration
Grape::Throttling.configure do |config|
  config.redis = ::Redis.new(url: 'redis://localhost:6379/0', driver: :hiredis)
  # Api overspeed access message custom method.
  # If doesn't respond，default message is "API rate limit exceeded."
  config.overspeed_message_method = :overspeed_message
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/OuYangJinTing/grape-throttling>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/OuYangJinTing/grape-throttling/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Grape::Throttling project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/OuYangJinTing/grape-throttling/blob/master/CODE_OF_CONDUCT.md).
