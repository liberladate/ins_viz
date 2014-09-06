module Ronin

  module Wiring
    def cache
      Cache.new(settings.cache)
    end
  end

end