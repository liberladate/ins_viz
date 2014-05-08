require 'sinatra'
require 'faraday'
require 'uri'
require 'dalli'
require 'memcachier'

require_relative 'app/table'

include URI::Escape
include Ronin

set :cache, Dalli::Client.new

get '/' do
  settings.cache.set('title', 'Vizualizare grafica a datelor INS ')
  puts settings.cache.get('title')
  haml :home, :locals => { :title => settings.cache.get('title')}
end

get '/table/:table_id' do
  content_type 'text/csv'

  Table.new(settings, params[:table_id], create_query(request)).csv
end

get '/graph/:table_id' do
  table = Table.new(settings, params[:table_id], create_query(request))

  haml :graph,
       :locals => {url_for_table: url_for_table(params[:table_id], request.query_string),
                   table_description: table.description,
                   measure_unit: table.measure_unit,
                   columns: table.columns_with_selected_values,
                   scheme: table.scheme,
                   title: settings.cache.get('title')}
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
