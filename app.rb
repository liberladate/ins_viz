require 'sinatra'
require 'faraday'
require 'uri'
require 'dalli'
require 'memcachier'

require_relative 'app/table_controller'
require_relative 'app/wiring'

module Ronin
  class Website < Sinatra::Base
    include URI::Escape
    include Wiring

    set :cache, Dalli::Client.new

    get '/' do
      haml :home, :locals => { :title => 'Vizualizare grafica a datelor INS '}
    end

    get '/table/:table_id' do
      content_type 'text/csv'

      table_controller.csv_for(params[:table_id], create_query(request))
    end

    get '/graph/:table_id' do

      table = table_controller.get_table(params[:table_id], create_query(request))

      haml :graph,
           :locals => {url_for_table: url_for_table(params[:table_id], request.query_string),
                       table_description: table.description,
                       measure_unit: table.measure_unit,
                       columns: table.columns_with_selected_values,
                       scheme: table.scheme,
                       title: 'Vizualizare grafica a datelor INS '}
    end

    def create_query(request)
      query = {}
      query_string = decode(request.query_string)
      query_string.split('&').each do |filter|
        key, value = filter.split('=')
        query[key] = value
      end
      query
    end

    def url_for_table(table_id, query)
      query = "?#{query}" unless query == ''
      "/table/#{table_id}#{query}"
    end

  end
end

