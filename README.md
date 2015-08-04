# example-synthetic-monitor
A **working example of website [synthetic monitoring](https://en.wikipedia.org/wiki/Synthetic_monitoring)** using the [synthetic_monitor gem](https://github.com/johnboyes/synthetic-monitor).

This example application is:
- **deployable on [Heroku](https://www.heroku.com/)** (see below) which makes it **very quick to get production monitoring up and running**
- specified using **plain old [RSpec](http://rspec.info/) tests**, which means that it is much more **easily customised** to your needs than most monitoring solutions.

It runs all the specs in the 'spec' folder, every 5 minutes, and **notifies any failures on a [Slack](https://slack.com/) channel or group** (with [SMS notifications coming soon](https://github.com/johnboyes/synthetic-monitor/issues/1)):

```ruby
SyntheticMonitor.new.monitor ENV['SLACK_WEBHOOK']
```
([jump to this code snippet](https://github.com/johnboyes/example-synthetic-monitor/blob/a8ede4c99801170ffa22faf575854adf091d574a/example_synthetic_monitor.rb#L1-L3))


Alternatively you can specify individual Slack notification channels or groups for individual spec files:

```ruby
spec_slack_pairs = {
  'spec/a_spec.rb' => ENV['A_SlACK_WEBHOOK'], 
  'spec/another_spec.rb' => ENV['A_DIFFERENT_SLACK_WEBHOOK'],
  'spec/a_third_spec.rb' => ENV['A_THIRD_SLACK_WEBHOOK'],
}

SyntheticMonitor.new.monitor_on_varying_slack_channels spec_slack_pairs
```

The monitoring frequency is customisable:

```ruby
SyntheticMonitor.new(frequency_in_minutes: 10).monitor
```

There is just the one spec in this example repository:

```ruby
scenario "monitor example.com" do
  @session.visit 'https://www.example.com'
  expect(@session).to have_content("This domain is established to be used for illustrative examples in documents.")
  expect(@session.status_code).to eq(200)
end
```
([jump to this code snippet](https://github.com/johnboyes/example-synthetic-monitor/blob/3543655f8d5c09295d1ed2ec456f0d731bec086c/spec/example_spec.rb#L13-L17))

## Prerequisites
- You must have [setup at least one Slack webhook](https://api.slack.com/incoming-webhooks) to send notifications to.
- [PhantomJS](https://github.com/teampoltergeist/poltergeist#installing-phantomjs)


## Running Locally

Make sure you have [Ruby](https://www.ruby-lang.org), [Bundler](http://bundler.io) and the [Heroku Toolbelt](https://toolbelt.heroku.com/) installed.

```sh
clone your own fork of this repository
cd name-of-your-fork
bundle
```
Create a .env file with the following content, replacing "put_a_slack_webhook_url_here" with your own Slack webhook:
```
SLACK_WEBHOOK=put_a_slack_webhook_url_here
```
and finally:
```sh
foreman start
```
[More info on foreman](https://devcenter.heroku.com/articles/procfile#developing-locally-with-foreman)

## Deploying to Heroku

```
heroku create --region eu
heroku buildpacks:add https://github.com/heroku/heroku-buildpack-ruby
heroku buildpacks:add https://github.com/stomita/heroku-buildpack-phantomjs
heroku config:set SLACK_WEBHOOK=put_a_slack_webhook_url_here
git push heroku master
heroku ps:scale worker=1
```

Alternatively, you can deploy your own copy of the app using the web-based flow:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

You will need to scale your worker process to 1 dyno, and then the monitoring will automatically start running.

For more information about using Ruby on Heroku, see these Dev Center articles:

- [Ruby on Heroku](https://devcenter.heroku.com/categories/ruby)
- [Getting Started with Ruby on Heroku](https://devcenter.heroku.com/articles/getting-started-with-ruby)
- [Heroku Ruby Support](https://devcenter.heroku.com/articles/ruby-support)

## Coming soon
- [SMS notifications](https://github.com/johnboyes/synthetic-monitor/issues/1)
- [Attach a screenshot to each notification](https://github.com/johnboyes/synthetic-monitor/issues/2)
