require 'rets'
require 'json'
require 'net/http'
# require 'rubysl-open-uri'
require 'open_uri_redirections'




request_uri = 'https://geocoding.geo.census.gov/geocoder/geographies/address?'
request_query = 'Street=4600+Silver+Hill+Rd&city=Suitland&state=MD&benchmark=Public_AR_Census2010&vintage=Census2010_Census2010&layers=14&format=json'
url = "#{request_uri}#{request_query}"
buffer = JSON.parse(open(url).read)

p block = buffer["result"]["addressMatches"][0]["geographies"]["Census Blocks"][0]["BLOCK"]
p tract = buffer["result"]["addressMatches"][0]["geographies"]["Census Blocks"][0]["TRACT"]
p lat = buffer["result"]["addressMatches"][0]["coordinates"]["x"]
p long = buffer["result"]["addressMatches"][0]["coordinates"]["y"]



# lattitude = y
# longitude = x


# https://geocoding.geo.census.gov/geocoder/geographies/address?street=1759+N+Kedzie+Ave&zip=60647&benchmark=Public_AR_Current&vintage=Census2010_Census2010&layer%20s=14&format=json

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

# property = client.find (:all), {
#   search_type: 'Property',
#   class: 'DE',
#   query: '(CIT=CHICAGO), (ST=CLSD), (CLOSEDDATE=2018-02-20)',
#   limit: 8000
# }


property.each do |child|

  sqft = child['ASF'].to_f #turnary 

  puts(child['HSN']<<' '<< child['CP'] <<' '<< child["STR"] <<' '<< child["STREETSUFFIX"] <<', Chicago, IL, '<< child['ZP'])
  puts(child['PIN'])
  puts(child['CLOSEDDATE'])
  salesPrice = child['SP'].to_f
  puts(salesPrice/sqft)

end

# 4f493480242111fa8c68a81679f0fe87fa6373a2

# pp allvalues
# pp property.inspect

# puts allvalues['HSN'] #housenumber
# puts allvalues['CP'] #street direction
# puts allvalues["STR"] #street 
# puts allvalues["STREETSUFFIX"] #street suffix
# puts allvalues['CIT'] #city
# puts allvalues['ZP'] #zipcode
# puts allvalues['LAT'] #lat 
# puts allvalues['LNG'] #long
# puts allvalues['PIN'] #parcel id
# puts allvalues['CLOSEDDATE']#closed Date
# puts allvalues["ASF"]#listed sqft
# puts property.size
# pp allvalues


#save to sql


client.logout
# photos = client.objects '*', {
#   resource: 'Property',
#   object_type: 'Photo',
#   resource_id: '06851616'
# }

# photos.each_with_index do |data, index|
#   File.open("property-#{index.to_s}.jpg", 'w') do |file|
#     file.write data.body
#   end
# end

# puts photos.length.to_s + ' photos saved.'
# client.logout