require 'redis'

module Ronin

  class Cache

    def initialize
      @connection = Faraday.new(:url => 'http://statistici.insse.ro')
      @cache_wrapper = Redis.new
    end

    def get_table(table)
      table_entry = "#{table.id}-#{table.query}"
      cache_value = @cache_wrapper.get(table_entry)
      if cache_value
        return cache_value
      else
        response = @connection.post('/shop/excelPivot.jsp', {:matCode => table.id, :encQuery => table.query})
        clean_response = cleanup_data_from_ins(response.body)
        @cache_wrapper.set(table_entry, clean_response) if response.status == 200
        return clean_response
      end
    end

    private
    def cleanup_data_from_ins(csv)
      csv.split("\n")[1..-1].collect do |line|
        (line.split(',').collect &:strip).join(',')
      end.join("\n")
    end

  end

end
