class PropertyController < ApplicationController
require_relative '../manipulation/stitch.rb'

  # get '/' do
  #   @propertys = Property.find property[:id] 
  #   # @propertys.to_json
  #   @page = "Index of propertys"
  #   erb :property_index
  #   end

  # # add route 
  # get '/add' do
  #   @page = "Add property"
  #   @action = "/propertys/add"
  #   @method = "POST"
  # end

    # create route
  post '/add' do
#     p '--------------------------------------------------'
# p Property.new
# p '------------------------------------------------'
    Stich.getProperty()

    'completed'
  end

  # # edit route
  # get '/edit/:id' do
  #   @property = property.find params[:id]
  #   @page = "Edit property #{@property.id}" #why am i using interpolation here?  try with concatenation and see what happens.
  #   erb :edit_property
  # end

  # # update route
  # patch '/:id' do
  #   @propertys = property.where(id: params[:id]) 
  #   @property = @propertys[0]
  #   @property.ppsqft = params[:ppsqft]
  #   @property.lat = params[:lat] # for now
  #   @property.long = params[:long]
  #   @property.save
  #   redirect '/propertys'
  # end

end


