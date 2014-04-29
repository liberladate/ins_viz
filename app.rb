require 'sinatra'
require 'faraday'
require_relative 'table'
require 'uri'

include URI::Escape

set :public_folder, 'public'

get '/' do
  haml :home
end

get '/table/:table_id' do
  content_type 'text/csv'

  Table.new(params[:table_id], create_query(request)).csv
end

get '/graph/:table_id' do
  table = Table.new(params[:table_id], create_query(request))

  haml :graph,
       :locals => {url_for_table: url_for_table(params[:table_id], request.query_string),
                   table_description: table.description,
                   measure_unit: table.measure_unit,
                   columns: table.columns_with_selected_values,
                   scheme: table.scheme}
end

def create_query(request)
  query = {}
  query_string = decode(request.query_string)
  query_string  .split('&').each do |filter|
    key, value = filter.split('=')
    query[key] = value
  end
  query
end

def url_for_table(table_id, query)
  query = "?#{query}" unless query == ''
  "/table/#{table_id}#{query}"
end
