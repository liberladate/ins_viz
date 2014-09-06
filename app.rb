require 'sinatra'
require 'faraday'
require 'dalli'
require 'memcachier'

require_relative 'app/table_controller'
require_relative 'app/wiring'

module Ronin
  class Website < Sinatra::Base
    include Wiring

    set :cache, Dalli::Client.new

    get '/' do
      haml :home
    end

    get '/table/:table_id' do
      content_type 'text/csv'

      table_controller.csv_for(params[:table_id], request.query_string)
    end

    get '/graph/:table_id' do

      table = table_controller.get_table(params[:table_id], request.query_string)

      haml :graph, locals: {table: table}
    end

  end
end

