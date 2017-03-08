require 'test_helper'

# Functional tests which verify the monitoring functionality
class FunctionalTest < Minitest::Test
  include Foreman::Test, Mirage::Test

  def setup
    ENV.store 'SLACK_WEBHOOK', 'http://localhost:7001/responses/slack'
    set_mock_slack_endpoint
    set_mock_success_endpoint
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
  end
end
