require 'pronto'

task :pronto do
  Pronto::GemNames.new.to_a.each { |gem_name| require "pronto/#{gem_name}" }
  Pronto.run('origin/master', '.', formatters)
end

def formatters
  [commit_formatter, status_formatter, pull_request_formatter].compact
end

def commit_formatter
  Pronto::Formatter::GithubFormatter.new
end

def status_formatter
  Pronto::Formatter::GithubStatusFormatter.new
end

def pull_request_formatter
  Pronto::Formatter::GithubPullRequestFormatter.new if pull_request_id_from_circleci
end

def pull_request_id_from_circleci
  ENV['CI_PULL_REQUEST']&.split('/')&.last
end
