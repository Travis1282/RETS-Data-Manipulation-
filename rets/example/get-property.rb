require 'rets'
require 'json'
require 'net/http'
# require 'rubysl-open-uri'
require 'open_uri_redirections'


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


(Date.new(2018,02,01)).upto(Date.new(2018, 02, 20)).each do |date|
  
   queryIter = '(CIT=CHICAGO), (ST=CLSD), (ClOSEDDATE='+(date.strftime("%Y-%d-%m")).to_s+')'

  property = client.find (:all), {
    search_type: 'Property',
    class: 'DE',
    # query: '(CIT=CHICAGO), (ST=CLSD), (CLOSEDDATE=2018-02-20)',
    query: queryIter,
    limit: 1
  }


  property.each do |child|

    
      sqft = child['ASF'].to_f

    unless sqft == 0 

      salesPrice = child['SP'].to_f
      puts closedate = 'Close Date: '<< (child['CLOSEDDATE'])
      puts ppsqft = 'Price Per Square Foot: '<< ((salesPrice/sqft).floor).to_s


      request_query =(child['HSN']<<' '<< child['CP'] <<' '<< child["STR"] <<' '<< child["STREETSUFFIX"] <<'city=Chicago&state=IL&zip='<< child["ZP"] << '&apikey=e3b6ccab4a5249abb5c37b6bbc6a3a8c&format=json&census=false&notStore=false&version=4.01')


     
      request_uri = 'https://geoservices.tamu.edu/Services/Geocode/WebService/GeocoderWebServiceHttpNonParsed_V04_01.aspx?streetAddress='
      url = "#{request_uri}#{request_query}"
      buffer = JSON.parse(open(url).read)
     
      p lat = 'lat: '<< buffer["OutputGeocodes"][0]["OutputGeocode"]["Latitude"]
      p long = 'long: '<< buffer["OutputGeocodes"][0]["OutputGeocode"]["Longitude"]

    end
  end
end

  client.logout





