class PropertyController < ApplicationController
require_relative '../manipulation/stitch.rb'

  get '/:datesold' do
    str =  "%#{params[:datesold]}%"
    # binding.pry
    properties = Property.where("datesold LIKE ?", str)

    properties.to_json

  end


    # create route
  post '/add' do

    Stich.getProperty()

    'completed' 
  end


end


