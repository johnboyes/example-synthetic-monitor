# example-synthetic-monitor
A working example of website synthetic monitoring using the [synthetic_monitor gem](https://github.com/johnboyes/synthetic-monitor).

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
