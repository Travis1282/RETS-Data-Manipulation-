require 'rets'
require 'json'
require 'net/http'
# require 'rubysl-open-uri'
require 'open_uri_redirections'

module Stich
    def Stich.getProperty()

# Pass the :login_url, :username, :password and :version of RETS



# client = Rets::Client.new({
#   login_url: 'xxx',
#   username: 'xxx',
#   password: 'xxx',
#   version: 'RETS/1.5'
# })

  begin
    client.login
  rescue => e
    puts '-------------------------'
    puts 'Error: ' + e.message
    exit!
  end

num = 0;
totalprops = 0;
totalpropsthisday = 0;
# loop the dates to find all closings on each date
(Date.new(2016,05,17)).upto(Date.new(2018, 03, 01)).each do |date|
  date_to_use = date.strftime("%Y-%m-%d")

  #format date in loop to work in the RETS query 
   queryIter = '(CIT=CHICAGO), (ST=CLSD), (CLOSEDDATE='+(date_to_use).to_s+')'
  # query rets server and

  begin
    puts ""
    puts "#{num}---------------------------"
    puts "checking for properties on ", date

    # query rets server 
    property = client.find (:all), {
      search_type: 'Property', 
      class: 'DE',
      # query: '(CIT=CHICAGO), (ST=CLSD), (CLOSEDDATE=2017-07-14)',
      query: queryIter,
     limit: 5000
    }


  # # loop each property for api call 
	 property.each do |child|

    
	      sqft = child['ASF'].to_f
	    # ignore if they did not list the sqft
	    unless sqft == 0 

	      salesPrice = child['SP'].to_f
	      dateSold = (child['CLOSEDDATE'])
	      ppsqft = ((salesPrice/sqft).floor).to_s

	      # form query format for geocoder api
	      request_query =(child['HSN']<<'+'<< child['CP'] <<'+'<< child["STR"] <<'+'<< child["STREETSUFFIX"] <<',+IL' << '&key=AIzaSyAqg6P3cv9UsSWp1X1omEiHWZIkYRsjqKE')
	      							# 1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyDPViyB3H7lAH7J7k9PP4Y51uqote8QQ5U &zip='<< child["ZP"]
	      # this is the api call 
	      request_uri = 'https://maps.googleapis.com/maps/api/geocode/json?address='
	       url = "#{request_uri}#{request_query}"
	       buffer = JSON.parse(open(url).read)

	      # the returned coordinates 
	     p lat = buffer['results'][0]['geometry']['location']['lat'] 
	     p long = buffer['results'][0]['geometry']['location']['lng']

	      totalprops = totalprops + 1
	      totalpropsthisday = totalpropsthisday + 1

			#### THis is the db stuff
			@instance = Property.new
			@instance.ppsqft = ppsqft
			@instance.lat = lat # for now
			@instance.long = long
			@instance.datesold = dateSold
			@instance.save
			# instance.save

	    end # unless
	  end # property.each do

		rescue Exception => e
		puts e.message
		end
		  puts "so far today: #{totalpropsthisday}"
		  puts "total properties so far: #{totalprops}"

		  num = num + 1
		  totalpropsthisday = 0
		end # unless
	  client.logout
    end # date



end # stitch class



