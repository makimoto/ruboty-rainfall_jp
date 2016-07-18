# Ruboty::RainfallJp

A Ruboty plugin to check rainfall forecast in Japan.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-rainfall_jp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruboty-rainfall_jp

## Usage

Use as a ruboty plugin.
It requires `YAHOO_JAPAN_APP_ID` environment variable.

```
> ruboty tell rainfall at Kyoto
Rainfall forecast: Kyoto (135.75141900,35.01042850)
07-18 22:15 0.0 mm/h
07-18 22:25 0.0 mm/h
07-18 22:35 0.0 mm/h
07-18 22:45 0.0 mm/h
07-18 22:55 0.0 mm/h
07-18 23:05 0.0 mm/h
07-18 23:15 0.0 mm/h
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/makimoto/ruboty-rainfall_jp.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
