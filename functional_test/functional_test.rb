require 'test_helper'

# Functional tests which verify the monitoring functionality
class FunctionalTest < Minitest::Test
  include Foreman::Test

  def setup
    ENV.store 'SLACK_WEBHOOK', 'http://localhost:7001/responses/slack'
    Mirage.start
    @mirage = Mirage::Client.new
    @mirage.put('slack', 'Notification received on Slack') { http_method 'POST' }
    @mirage.put('success', 'Success notification received') { http_method 'POST' }
  end

  def test_run_app_which_then_runs_all_specs
    @monitor_thread = Thread.new { `foreman start` }
    assert_notification_sent_to_slack
    assert_no_success_notification_sent
  end

  def test_run_failure_spec
    @monitor_thread = Thread.new { SyntheticMonitor.new.monitor('spec/failure_spec.rb', ENV['SLACK_WEBHOOK']) }
    assert_notification_sent_to_slack
    assert_no_success_notification_sent
  end

  def test_run_success_spec
    @monitor_thread = Thread.new do
      monitor = SyntheticMonitor.new(success_notifications_url: success_notifications_post_url)
      monitor.monitor('spec/success_spec.rb', ENV['SLACK_WEBHOOK'])
    end
    assert_success_notification_sent
    assert_no_notification_sent_to_slack
  end

  def teardown
    @monitor_thread.exit
    @mirage.clear
    Mirage.stop
  end
end
