module Ronin

  module Wiring
    def cache
      Cache.new(settings.cache)
    end

    def table_controller
      TableController.new(cache)
    end
  end

end