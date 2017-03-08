module Foreman
  # Ensures that if a foreman process is started in a test, it is then killed on teardown
  module Test
    def before_setup
      super
      @before_foreman_pids = foreman_pids
    end

    def after_teardown
      foreman_pids_to_kill.each { |pid| kill_foreman_process pid }
      super
    end

    private

    def kill_foreman_process(pid)
      `kill -9 #{pid}`
    end

    def foreman_pids_to_kill
      foreman_pids - @before_foreman_pids
    end

    # the currently running foreman process ids
    def foreman_pids
      `ps aux | grep "[f]oreman: master" | awk '{ print $2 }'`.split("\n")
    end
  end
end
