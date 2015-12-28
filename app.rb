require 'sinatra'
require 'faraday'

require_relative 'app/wiring'
require_relative 'app/models/data_set'

require 'json'

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
      haml :browse, locals: {data: data_sets}
    end

    get '/search' do
      data_sets = []
      random_data_sets = []
      if term = params[:term]
        data_sets = metadata.search_category(term)
      else
        random_data_sets = metadata.get_random_categories(5)
      end

      haml :search, locals: {random_data_sets: random_data_sets, search_results: data_sets}
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

  end
end
