class ApplicationController < Sinatra::Base

	# require 'bundler'
	# Bundler.require()

	enable :sessions

	# set :views, File.expand_path('../views', File.dirname(__FILE__))

	ActiveRecord::Base.establish_connection(
		:adapter => 'postgresql',
		:database => 'heatmap'
		)

	

end
