class DataSet
    attr_reader :description
    def initialize(name: 'none', description: 'none')
      @name = name
      @description = description
    end

    def url
      "/graph/#{@name}"
    end
end
