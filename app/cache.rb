module Ronin

  class Cache

    def initialize(cache_wrapper)
      @connection = Faraday.new(:url => 'http://statistici.insse.ro')
      @cache_wrapper = cache_wrapper
    end

    def get_table(table_id, query)
      table_entry = "#{table_id}-#{query}"
      cache_value = @cache_wrapper.get(table_entry)
      if cache_value
        return cache_value
      else
        response = @connection.post('/shop/excelPivot.jsp', {:matCode => table_id, :encQuery => query})
        @cache_wrapper.set(table_entry, response.body) if response.status == 200
        return response.body
      end
    end

  end

end