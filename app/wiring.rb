require_relative 'cache'
require_relative 'table_controller'
require_relative 'ins_data_store'

module Ronin

  module Wiring
    def cache
      Cache.new
    end

    def table_controller
      TableController.new
    end

    def ins_data_store
      INSDataStore.new(cache)
    end

  end

end
