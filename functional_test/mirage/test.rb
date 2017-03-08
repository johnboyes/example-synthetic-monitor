module Mirage
  # Setup and teardown a Mirage (https://github.com/lashd/mirage) mockserver.
  module Test
    def before_setup
      super
      Mirage.start
      @mirage = Mirage::Client.new
    end

    def after_teardown
      @mirage.clear
      Mirage.stop
      super
    end
  end
end
