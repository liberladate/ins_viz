require 'sinatra'
require 'faraday'

require_relative 'app/wiring'
require_relative 'app/models/data_set'

require 'json'

module Ronin
  class Website < Sinatra::Base
    include Wiring

    get '/' do
      haml :home
    end

    get '/search' do
      top_data_sets = [
        DataSet.new(name: 'POP101A', description: 'Populatia stabila pe sexe, etc'),
        DataSet.new(name: 'CON110A', description: 'Productivitatea muncii, etc')
      ]
      haml :search, locals: {top_data_sets: top_data_sets, search_results: []}
    end

    get '/search/:term' do
      term = params[:term]
      data_sets = metadata.search_category(term).map {|json| DataSet.fromJSON(json)}
      haml :search, locals: {top_data_sets: [], search_results: data_sets}
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
