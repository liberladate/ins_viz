module Ronin
  class INSDataStore

    def initialize(cache)
      @cache = cache
    end

    def get_table(table)
      @cache.get_table(table)
    end

  end
end
