require 'json'
require_relative 'cache'
require_relative 'models/table'
require 'uri'


module Ronin

  class TableController

    include URI::Escape

    def get_table(id, query_string)
      Table.new(id, create_query(query_string))
    end

    private
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