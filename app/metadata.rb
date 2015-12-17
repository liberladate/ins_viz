require 'json'
class Metadata
  def initialize(metadata_file)
    @metadata_file = metadata_file
    @categories = JSON.parse(File.read(metadata_file))
  end

  def search_category(term)
    @categories.select do |category|
      category['description'].include?(term)
    end
  end
end
