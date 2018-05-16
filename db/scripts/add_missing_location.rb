# This was *going* to be used to update locations of dive_centers where the google_geocode
# API failed due to a max quota. However, I ended up running the scrape for the location
# over two days so I didn't hit the quota, so I never actually fully tested this script.
# It did update *every* single

def add_missing_location
  dive_centers = DiveCenter.all.select { |dc| dc.location.country == nil }

  dive_centers.each do |dc|
    loc = Location.find(dc.location) # this was the missing part!!!

    address_json = find_address(dc.location.lat, dc.location.lng)
    loc_attributes = parse_google_geocode(address_json)

    puts 'updating location...'
    loc_attributes[:source] = 'SSI'
    loc = Location.update(loc_attributes)
  end
end
