require 'sinatra/base'
require 'sinatra/activerecord'


#models 
require './models/PropertyModel'

# controllers
require './controllers/ApplicationController'
require './controllers/PropertyController'




# routes
map ('/') {
	run ApplicationController
}

map ('/properties') { 
	run PropertyController
}
 