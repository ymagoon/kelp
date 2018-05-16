# This was *going* to be used to update locations of dive_centers where the google_geocode
# API failed due to a max quota. However, I ended up running the scrape for the location
# over two days so I didn't hit the quota, so I never actually fully tested this script.
# It did update *every* single

def add_missing_location
  dive_centers = DiveCenter.all.select { |dc| dc.location.country == nil }
  size = dive_centers.size

  dive_centers.each_with_index do |dc, index|
    puts "updating address #{index} of #{size}"
    address_json = find_address(dc.location.lat, dc.location.lng)
    # ap address_json
    # Added to ensure I'm not adding shit addresses to the DB
    if address_json[1] == 'OK'
      loc_attributes = parse_google_geocode(address_json[0])
    elsif address_json[1] == 'OVER_QUERY_LIMIT'
      puts 'over query limit for google geocode api...'
      break
    elsif address_json[1] == 'ZERO_RESULTS'
      puts 'no results found...'
      next
    else
      puts 'something didnt work here, so we wont do anything'
      next
    end

    puts 'updating location...'
    loc_attributes[:source] = 'SSI'
    dc.location.update(loc_attributes)
  end
end
