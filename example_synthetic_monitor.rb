require 'synthetic_monitor'

SyntheticMonitor.new.monitor ENV['SLACK_WEBHOOK_URL']
