module Ronin
  module Test
    module Navigation
      def homepage
        visit '/'

        Capybara.current_session
      end

      def table(table_id)
        visit "/table/#{table_id}"

        Capybara.current_session
      end
    end
  end
end
