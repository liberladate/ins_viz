require 'sinatra'
require 'faraday'
require_relative 'table'

set :public_folder, 'public'

get '/' do
  haml :home
end

get '/table/:table_id' do
  content_type 'text/csv'

  query = {}
  request.query_string.split('&').each do |filter|
    key,value = filter.split('=')
    query[key] = value
  end

  Table.new(params[:table_id], query).csv
end

get '/graph/:table_id' do
  query = {}
  request.query_string.split('&').each do |filter|
    key,value = filter.split('=')
    query[key] = value
  end

  table = Table.new(params[:table_id], query)
  haml :graph,
       :locals => {url_for_table: url_for_table(params[:table_id], request.query_string),
                   table_description: table.description,
                   measure_unit: table.measure_unit,
                   columns: table.columns_with_selected_values}
end


def url_for_table(table_id, query)
  query = "?#{query}" unless query == ''
  "/table/#{table_id}#{query}"
end
