# example-synthetic-monitor
A **working example of website synthetic monitoring** using the [synthetic_monitor gem](https://github.com/johnboyes/synthetic-monitor).

The application is **deployable on Heroku** (see below) which makes it **very quick to get production monitoring up and running**, and the fact that the tests are **plain old [RSpec](http://rspec.info/) tests** means that your checks are much more **easily customised** to your needs than most monitoring solutions.

Run all the specs in the 'spec' folder by default, every 5 minutes, and **notify any failures to a [Slack](https://slack.com/) channel or group** (with [SMS notifications coming soon](https://github.com/johnboyes/synthetic-monitor/issues/1)).

```ruby
SyntheticMonitor.new.monitor ENV['SLACK_WEBHOOK_URL']
```
([jump to this code snippet](https://github.com/johnboyes/example-synthetic-monitor/blob/a8ede4c99801170ffa22faf575854adf091d574a/example_synthetic_monitor.rb#L1-L3))


Alternatively you can have individual spec files notify to an individual Slack channel or group:

```ruby
spec_slack_pairs = {
  'spec/a_spec.rb' => ENV['A_SlACK_WEBHOOK_URL'], 
  'spec/another_spec.rb' => ENV['A_DIFFERENT_SLACK_WEBHOOK_URL'],
  'spec/a_third_spec.rb' => ENV['A_THIRD_SLACK_WEBHOOK_URL'],
}

SyntheticMonitor.new.monitor_on_varying_slack_channels spec_slack_pairs
```

There is only one spec in this example repository:

```ruby
scenario "monitor example.com" do
  @session.visit 'https://www.example.com'
  expect(@session).to have_content("This domain is established to be used for illustrative examples in documents.")
  expect(@session.status_code).to eq(200)
end
```
([jump to this code snippet](https://github.com/johnboyes/example-synthetic-monitor/blob/3543655f8d5c09295d1ed2ec456f0d731bec086c/spec/example_spec.rb#L13-L17))


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

## Coming soon
- [SMS notifications](https://github.com/johnboyes/synthetic-monitor/issues/1)
- [Attach a screenshot to each notification](https://github.com/johnboyes/synthetic-monitor/issues/2)
