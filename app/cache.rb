module Ronin

  class Cache

    def initialize(cache_wrapper)
      @connection = Faraday.new(:url => 'http://statistici.insse.ro')
      @cache_wrapper = cache_wrapper
    end

    def get(table, query)
      entry = "#{table}-#{query}"
      cache_value = @cache_wrapper.get(entry)
      if cache_value
        return cache_value
      else
        response = @connection.post('/shop/excelPivot.jsp', {:matCode => table, :encQuery => query})
        @cache_wrapper.set(entry, response.body) if response.status == 200
        return response.body
      end
    end

  end

end