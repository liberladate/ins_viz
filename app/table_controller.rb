require 'json'
require_relative 'cache'
require_relative 'models/table'
require 'uri'


module Ronin
  class TableController

    include URI::Escape

    def initialize(cache)
      @cache = cache
    end

    def get_table(id, query_string)
      Table.new(id, create_query(query_string))
    end

    def csv_for(table_id, query_string)
      ins_query = get_table(table_id, query_string).query
      csv = @cache.get_table(table_id, ins_query)

      cleanup_data_from_ins(csv)
    end

    private
    def cleanup_data_from_ins(csv)
      csv.split("\n")[1..-1].collect do |line|
        (line.split(',').collect &:strip).join(',')
      end.join("\n")
    end

    def create_query(query_string)
      query = {}
      query_string = decode(query_string)
      query_string.split('&').each do |filter|
        key, value = filter.split('=')
        query[key] = value
      end
      query
    end

  end
end