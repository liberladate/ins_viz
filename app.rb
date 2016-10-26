require 'sinatra'
require 'faraday'

require_relative 'app/wiring'
require_relative 'app/models/data_set'

require 'json'
require 'rdiscount'

module Ronin
  class Website < Sinatra::Base
    include Wiring

    get '/' do
      data_sets = metadata.get_all
      data_sets = data_sets.group_by do |table|
        table.category
      end
      data_sets = data_sets.each_pair do |category, tables|
        data_sets[category] = tables.group_by do |table|
          table.subcategory
        end
      end

      card_groupings = data_sets.select {|_, tables| tables.length > 1}
      single_value_items = data_sets.select { |_, tables| tables.length <= 1 }
      card_groupings['Altele'] = single_value_items.keys.reduce({}) {|result, key| result.merge(single_value_items[key]) }

      random_data_sets = metadata.get_random_categories(3)

      haml :browse, locals: {data: card_groupings, random_data_sets: random_data_sets}
    end

    get '/categorie/:category_name' do
      category = params[:category_name]
      tables = metadata.get_all.select {|table| table.subcategory == category }
      haml :category, locals: {data: tables, category: category}
    end

    get '/contact' do
      haml :contact
    end

    get '/search' do
      term = params[:term]
      data_sets = term ? metadata.search_category(term) : []

      haml :search, locals: {search_results: data_sets}
    end

    get '/table/:table_id' do
      content_type 'text/csv'

      table = table_controller.get_table(params[:table_id], request.query_string)
      ins_data_store.get_table(table)
    end

    get '/graph/:table_id' do
      table = table_controller.get_table(params[:table_id], request.query_string)

      haml :graph, locals: {table: table}
    end

    get '/despre' do
      content = markdown File.read('README.md')
      haml content
    end

  end
end
