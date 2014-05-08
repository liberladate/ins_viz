module Ronin

  class Cache

    def initialize(settings)
      @settings = settings
      @connection = Faraday.new(:url => 'http://statistici.insse.ro')
    end

    def get(table, query)
      entry = "#{table}-#{query}"
      cache_value = @settings.cache.get(entry)
      if cache_value
        return cache_value
      else
        response = @connection.post('/shop/excelPivot.jsp', {:matCode => table, :encQuery => query})
        @settings.cache.set(entry, response.body) if response.status == 200
        return response.body
      end
    end

  end

end