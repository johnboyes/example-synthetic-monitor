# example-synthetic-monitor
A working example of website synthetic monitoring using the [synthetic_monitor gem](https://github.com/johnboyes/synthetic-monitor).

It runs all the specs in the 'spec' folder by default, every 5 minutes, and notifies any failures to a [Slack](https://slack.com/) channel or group:

([jump to this code snippet](https://github.com/johnboyes/example-synthetic-monitor/blob/a8ede4c99801170ffa22faf575854adf091d574a/example_synthetic_monitor.rb#L1-L3))

```ruby
require 'synthetic_monitor'
SyntheticMonitor.new.monitor ENV['SLACK_WEBHOOK_URL']
```

## Running Locally

Make sure you have [Ruby](https://www.ruby-lang.org), [Bundler](http://bundler.io) and the [Heroku Toolbelt](https://toolbelt.heroku.com/) installed.

```sh
clone your own fork of this repository
cd name-of-your-fork
bundle
foreman start
```
[More info on foreman](https://devcenter.heroku.com/articles/procfile#developing-locally-with-foreman)

## Deploying to Heroku

```
heroku create
git push heroku master
```

Alternatively, you can deploy your own copy of the app using the web-based flow:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

For more information about using Ruby on Heroku, see these Dev Center articles:

- [Ruby on Heroku](https://devcenter.heroku.com/categories/ruby)
- [Getting Started with Ruby on Heroku](https://devcenter.heroku.com/articles/getting-started-with-ruby)
- [Heroku Ruby Support](https://devcenter.heroku.com/articles/ruby-support)
