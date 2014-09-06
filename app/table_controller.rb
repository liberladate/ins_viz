require 'json'
require_relative 'cache'
require_relative 'models/table'

module Ronin
  class TableController

    def initialize(cache)
      @cache = cache
    end

    def get_table(id, query = {})
      Table.new(id, query)
    end

    def csv_for(table_id, query)

      csv = @cache.get_table(table_id, query)

      cleanup_data_from_ins(csv)
    end

    private
    def cleanup_data_from_ins(csv)
      csv.split("\n")[1..-1].collect do |line|
        (line.split(',').collect &:strip).join(',')
      end.join("\n")
    end
  end
end