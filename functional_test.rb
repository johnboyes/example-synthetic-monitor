require 'minitest/autorun'
require 'minitest/spec'
require 'synthetic_monitor'
require 'mirage/client'
require 'pry'
 
  class FunctionalTest < Minitest::Test

  	def test_monitoring
  	  Mirage.start
  	  mirage = Mirage::Client.new
  	  mirage.put('slack', 'Notification received on Slack') { http_method 'POST' }
  	  foreman_thread = Thread.new {`foreman start`}
  	  sleep 10
      foreman_thread.exit
  	  expected_response_body = '{\"attachments\":[{\"fallback\":\"ALERT: 1 test failed\",\"color\":\"danger\",\"title\":\"ALERT: 1 test failed\",\"fields\":[{\"title\":\"example example of a test which will fail, triggering a notification on Slack\",\"value\":\"\\n\\nexpected: 500\\n     got: 200\\n\\n(compared using ==)\\n\\n# ./spec/example_spec.rb:19\\n===================================================\"}]}]}'
	  assert_same(expected_response_body, mirage.requests(1).body)
  	  Mirage.stop
    end
 
  end