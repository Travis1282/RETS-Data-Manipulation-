class PropertyController < ApplicationController
require_relative '../manipulation/stitch.rb'

  get '/:datesold' do
    # @property = Property.find (params[:id]) 
    str =  "%#{params[:datesold]}%"
    # binding.pry
    properties = Property.where("datesold LIKE ?", str)



    # p params[:id]
    # @project = Project.find params[:id]
    # @datesold = property.datesold
    # @lat = property.lat
    # @long = property.long

    # resp = {
    #   status: {
    #     success: true,
    #     lat: @lat,
    #     long: @long,
    #     datesold: @datesold
    #     # message: "returning a property on #{@property.datesold}",
    #   },
    #   # tasks: @property.datesold
    # }
    properties.to_json
    # resp.to_json

  end


    # create route
  post '/add' do

    Stich.getProperty()

    'completed' 
  end


end


