class DataSet
    attr_reader :description, :category, :subcategory
    def initialize(name: 'none', description: 'none', category: 'A', subcategory: 'A1')
      @name = name
      @description = description
      @category = category
      @subcategory = subcategory
    end

    def self.fromJSON(json)
      DataSet.new(name: json['name'], description: json['description'], category: json['category'], subcategory: json['subcategory'])
    end

    def url
      "/graph/#{@name}"
    end
end
