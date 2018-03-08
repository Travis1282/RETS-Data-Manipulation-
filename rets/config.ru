require 'sinatra/base'
require 'sinatra/activerecord'


#models 
require './models/PropertyModel'

# controllers
require './controllers/ApplicationController'
require './controllers/PropertyController'
require './controllers/AllDatesController'




# routes
map ('/') {
	run ApplicationController
}

map ('/properties') { 
	run PropertyController
}
 
map ('/dates') { 
	run AllDatesController
}
 