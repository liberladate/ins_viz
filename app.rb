require 'sinatra'
require 'faraday'
require_relative 'table'

set :public_folder, 'public'

get '/' do
  haml :home
end

get '/table/:table_id' do
  content_type 'text/csv'

  Table.new(params[:table_id]).csv
end

get '/graph/:table_id' do
  table = Table.new(params[:table_id])
  haml :graph, :locals => {:table_id => params[:table_id], :table_description => table.description}
end