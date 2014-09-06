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
      haml :home
    end

    get '/table/:table_id' do
      content_type 'text/csv'

      table_controller.csv_for(params[:table_id], create_query(request))
    end

    get '/graph/:table_id' do

      table = table_controller.get_table(params[:table_id], create_query(request))

      haml :graph, locals: {table: table}
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

  end
end

