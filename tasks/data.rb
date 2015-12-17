require 'json'
task :flatten_categories do
   contents = File.read('public/js/ins_short.js')
   contents = contents.split('var category_data =').last.chop
   categories = JSON.parse(contents)
   data_sets = []
   categories.each_pair do |category, subcategories|
     subcategories.each_pair do |subcategory, tables|
       tables.each_pair do |name, description|
         data_sets << {
           name: name,
           description: description['description'],
           category: category,
           subcategory: subcategory
         }
       end
     end
   end
   File.open('data/categories.json', 'w') {|f| f.write(JSON.generate(data_sets))}
end
