require_relative 'spec_helper'

module Ronin
  module Test

    describe 'Homepage' do

      it 'should have the correct title' do
        expect(homepage.title).to eq 'Vizualizare grafica a datelor INS'
      end
    end

  end
end
