require 'rets'
require 'json'
require 'net/http'
# require 'rubysl-open-uri'
require 'open_uri_redirections'

module Stich
    def Stich.getProperty()

# Pass the :login_url, :username, :password and :version of RETS

client = Rets::Client.new({
  login_url: 'http://connectmls-rets.mredllc.com/rets/server/login',
  username: 'RETS_O_12604_2',
  password: '2nwj2xbkgd',
  version: 'RETS/1.5'
})

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
(Date.new(2016,04,21)).upto(Date.new(2016, 12, 31)).each do |date|
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
	      request_query =(child['HSN']<<' '<< child['CP'] <<' '<< child["STR"] <<' '<< child["STREETSUFFIX"] <<'city=Chicago&state=IL&zip='<< child["ZP"] << '&apikey=e3b6ccab4a5249abb5c37b6bbc6a3a8c&format=json&census=false&notStore=false&version=4.01')

	      # this is the api call 
	      request_uri = 'https://geoservices.tamu.edu/Services/Geocode/WebService/GeocoderWebServiceHttpNonParsed_V04_01.aspx?streetAddress='
	      url = "#{request_uri}#{request_query}"
	      buffer = JSON.parse(open(url).read)
	     
	      # the returned coordinates 
	      lat = buffer["OutputGeocodes"][0]["OutputGeocode"]["Latitude"]
	      long = buffer["OutputGeocodes"][0]["OutputGeocode"]["Longitude"]

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



