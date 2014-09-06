require_relative 'spec_helper'

module Ronin
  module Test

    describe 'Homepage' do
      it 'should have the correct title' do
        expect(homepage.title).to eq 'Vizualizare grafica a datelor INS'
      end
    end

    describe 'Table CSV' do
      it 'should return a 200 page when asking for a table in csv format' do
        expect(table_csv('POP101A').response_headers['Content-Type']).to include 'text/csv'
      end
    end

    describe 'Table graph page' do
      it 'should return a page with the correct title' do
        expect(graph('POP101A').title).to include 'Vizualizare grafica a datelor INS'
      end
    end

  end
end
