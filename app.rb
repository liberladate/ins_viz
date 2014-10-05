require 'sinatra'
require 'faraday'

require_relative 'app/wiring'

module Ronin
  class Website < Sinatra::Base
    include Wiring

    get '/' do
      haml :home
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
