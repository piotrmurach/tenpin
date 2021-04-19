<div align="center">
  <img width="400" src="https://github.com/piotrmurach/tenpin/blob/master/assets/tenpin-logo.png" alt="tenpin logo" />
</div>

# Tenpin

[![Gem Version](https://badge.fury.io/rb/tenpin.svg)][gem]
[![Actions CI](https://github.com/piotrmurach/tenpin/workflows/CI/badge.svg?branch=master)][gh_actions_ci]
[![Build status](https://ci.appveyor.com/api/projects/status/ne0fxoail747nwu0?svg=true)][appveyor]
[![Code Climate](https://codeclimate.com/github/piotrmurach/tenpin/badges/gpa.svg)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/github/piotrmurach/tenpin/badge.svg)][coverage]
[![Inline docs](http://inch-ci.org/github/piotrmurach/tenpin.svg?branch=master)][inchpages]

[gem]: http://badge.fury.io/rb/tenpin
[gh_actions_ci]: https://github.com/piotrmurach/tenpin/actions?query=workflow%3ACI
[appveyor]: https://ci.appveyor.com/project/piotrmurach/tenpin
[codeclimate]: https://codeclimate.com/github/piotrmurach/tenpin
[coverage]: https://coveralls.io/github/piotrmurach/tenpin
[inchpages]: http://inch-ci.org/github/piotrmurach/tenpin

> Terminal "tenpin" bowling game built with [TTY toolkit components](https://ttytoolkit.org/components/).

Bowling known as "ten pins" is a game played by rolling a heavy ball down a narrow lane and attempting to knock down ten pins arranged in a triangle. A player can bowl up to two times per "frame", and a game consists of ten frames. A special rule applies to the last frame in which you can roll up to three times if you have a strike or a spare.

If a player knocks down all ten pins in the first throw, then they have what is called a "strike", and no second ball is rolled in the frame. When some or none pins are knocked down in the first throw, then a second ball is awarded. If all pins are knocked down in the second roll, then the player gets a "spare".

The maximum number of points possible is 300 which a player can get by rolling 12 strikes in a row.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tenpin'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tenpin

## Usage

Run the game:

```
$ tenpin
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/piotrmurach/tenpin. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [GNU Affero General Public License v3.0](https://opensource.org/licenses/AGPL-3.0).

## Code of Conduct

Everyone interacting in the Tenpin project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/piotrmurach/tenpin/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2019 Piotr Murach. See [LICENSE.txt](LICENSE.txt) for further details.
