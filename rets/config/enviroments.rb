
configure :production, :development do
	db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/9292')

	ActiveRecord::Base.establish_connection(
		:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
		:lat => db.lat,
		:long => db.long,
		:ppsqft => db.ppsqft,
		:datesold => db.datesold,
		:encoding => 'utf8'
	)
end
