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
