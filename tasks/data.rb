require 'json'
task :flatten_categories do
   contents = File.read('public/js/ins_short.js')
   contents = contents.split('var category_data =').last.chop
   categories = JSON.parse(contents)
   data_sets = categories.values.flat_map {|item| item.values}.map {|hash|
      arr = []
      hash.each_pair { |k,v|
        arr << {name: k, description: v["description"]}
      }
      arr
   }.flatten
   File.open('data/categories.json', 'w') {|f| f.write(JSON.generate(data_sets))}
end
