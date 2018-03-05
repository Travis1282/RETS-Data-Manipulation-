class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require()

	# require '../config/environments'
	
	enable :sessions
	set :views, File.expand_path("../../views", __FILE__)
	set :public_dir, File.expand_path("../../public", __FILE__)
	
	# register Sinatra::CrossOrigin

	ActiveRecord::Base.establish_connection(
		:adapter => 'postgresql',
		:database => 'heatmap'
		)

	
	set :allow_origin, :any
	set :allow_methods, [:get, :post, :options, :put, :delete]


end
