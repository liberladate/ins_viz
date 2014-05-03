module Ronin
  module Test
    module Navigation
      def homepage
        visit '/'

        Capybara.current_session
      end
    end
  end
end
