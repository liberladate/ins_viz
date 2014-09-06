module Ronin
  module Test
    module Navigation
      def homepage
        visit '/'

        Capybara.current_session
      end

      def table_csv(table_id)
        visit "/table/#{table_id}"

        Capybara.current_session
      end

      def graph(table_id)
        visit "/graph/#{table_id}"

        Capybara.current_session
      end

    end
  end
end
