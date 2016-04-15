# HashFingerprint

[![Build Status](https://travis-ci.org/jasonyost/hash_fingerprint.svg?branch=master)](https://travis-ci.org/jasonyost/hash_fingerprint) [![Gem Version](https://badge.fury.io/rb/hash_fingerprint.svg)](https://badge.fury.io/rb/hash_fingerprint)

Create a SHA256 fingerprint of a hash or array

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hash_fingerprint'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install hash_fingerprint
```

## Usage

```ruby
require 'hash_fingerprint'
hash = { a: { b: 'b', c: 'c' }, d: 'd', e: { f: 1, g: 2 } }
HashFingerprint.fingerprint hash
# => "6355f75aadd5a4841b87b88bb8f25304b706feafd33e84a8d8a47a97baa5d730"

a1 = [1, 2, 3, [4, [5, 6]], %w(a b c)]
a2 = [%w(c b a), 3, 2, 1, [[5, 6], 4]]
HashFingerprint.compare a1 a2
# => true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/jasonyost/hash_fingerprint>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
