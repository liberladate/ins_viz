require 'json'
class Metadata
  def initialize(metadata_file)
    @metadata_file = metadata_file
    @categories = JSON.parse(File.read(metadata_file))
  end

  def search_category(term)
    to_data_set(@categories.select do |category|
      category['description'].include?(term)
    end)
  end

  def get_random_categories(number)
    to_data_set((1..number).to_a.map do
      @categories[rand(@categories.size)]
    end)
  end

  def to_data_set(list)
    list.map {|json| DataSet.fromJSON(json)}
  end
end
