class DataSet
    attr_reader :description
    def initialize(name: 'none', description: 'none')
      @name = name
      @description = description
    end

    def self.fromJSON(json)
      DataSet.new(name: json['name'], description: json['description'])
    end

    def url
      "/graph/#{@name}"
    end
end
