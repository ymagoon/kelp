def scrape_padi_dive_centers
  dive_centers = []
  padi = TrainingOrganization.find_by(short_name: "PADI")

  # Loop over all latitudes
  c_lat = 90

  while c_lat >= -90 && c_lat <= 80
    if c_lat <= 80 && c_lat >= -80
      n_lat = c_lat + 10
    elsif c_lat >= 90
      n_lat = 90
    else
      n_lat = -90
    end

    s_lat = c_lat >= -80 ? c_lat - 10 : -90
    puts "c_lat: #{c_lat} n_lat:#{n_lat} s_lat:#{s_lat}"

    # Loop over all longitudes
    c_lng = -180

    while c_lng >= -180 && c_lng <= 170
      if c_lng >= -170 && c_lng <= 170
        w_lng = c_lng - 10
      elsif c_lng <= -170
        w_lng = -180
      else
        w_lng = 180
      end

      e_lng = c_lng <= 170 ? c_lng + 10 : 180

      params = { cLat: c_lat,
           cLong: c_lng,
           courseIds: '',
           distanceMeters: '1000000',
           eLng: e_lng,
           levelIds: '5',
           mapSize: 'smaller',
           nLat: n_lat,
           offeringIds: '',
           sLat: s_lat,
           searchString:'',
           specialtyId: '-1',
           storeNumber: '-1',
           wLng: w_lng }

      json = JSON.parse(RestClient.post 'http://apps.padi.com/scuba-diving/dive-shop-locator/Dsl/GetDiveShops', params)

      if json['RecordCount'] != 0
        json['SearchRecords'].each do |dc|
          # Create DC location
          loc_attributes = {}
          loc_attributes[:source] = 'PADI'
          loc_attributes[:address_1] = dc['Address1']
          loc_attributes[:address_2] = dc['Address2']
          loc_attributes[:lat] = dc['Latitude']
          loc_attributes[:lng] = dc['Longitude']
          loc_attributes[:city] = dc['City']
          loc_attributes[:state] = dc['State']
          loc_attributes[:country] = dc['Country']
          loc_attributes[:postal_code] = dc['Zip']

          puts 'creating location...'
          loc = Location.create!(loc_attributes)

          # Create DC
          dc_attributes = {}
          dc_attributes[:location] = loc
          dc_attributes[:name] = dc['StoreName']
          dc_attributes[:primary_phone] = dc['Phone']
          dc_attributes[:website] = dc['Web']
          dc_attributes[:fax] = dc['Fax']
          dc_attributes[:email] = dc['Email']
          dc_attributes[:fb] = dc['FB']
          dc_attributes[:twitter] = dc['Twitter']
          dc_attributes[:youtube] = dc['YouTube']
          dc_attributes[:google] = dc['Google']
          dc_attributes[:linkedin] = dc['LinkedIn']
          dc_attributes[:blog] = dc['Blog']
          dc_attributes[:tripadvisor] = dc['TripAdvisor']
          dive_center[:dive_center_type] = dc['CredentialCode'] #finish

          puts 'creating dc...'
          dive_center = DiveCenter.create!(dc_attributes)

          puts 'creating agency...'
          agency = {}
          agency[:store_number] = dc['StoreNumber']
          agency[:dive_center] = dive_center
          agency[:training_organization] = padi
          Agency.create!(agency)

          dive_centers << dive_center
        end
      end
      c_lng += 10
      sleep(1)
      puts "c_lng: #{c_lng} w_lng:#{w_lng} e_lng:#{e_lng} dive_centers:#{dive_centers.count}"
    end
    puts "finished c_lat:#{c_lat} centers found: #{dive_centers.count}"
    c_lat -= 10
  end
  p dive_centers
  p dive_centers.count

# {"GUID":"00000000-0000-0000-0000-000000000000","RecordCount":0,"SearchRecords":[],
# "ErrorMessage":"","StackTrace":"","SearchString":"","LocationGeoPoint":{"X":80,"Y":80},
# "Distance":1000000,"MapSize":"\"larger\"","LevelIDs":"3,2,1","Bounds":{"NorthEast":{"X":90,"Y":70},
# "SouthWest":{"X":70,"Y":90}},"IpAddress":"103.247.121.146"}
# say we start at 0 0
end

# from san diego as I move towards ny the longitude values go from -117 to -116 (increasing)
# from san diego as I move up towards Canada, latitude values increase 33 -> 34
# there is a breaking point at -180, where everything to the right is neg ( < -180) and
# it immediately jumps to positive from POS 180 counting down
# x asis is -180 -> 180
# clat, nlat, slat are never larger than 90
# equator, the latitude is 0
# latitude never goes below -90

# clat 0, clong 123.40075980000006, elng 180, slat 0, wlng -18, nlat 15
# "LocationGeoPoint":{"X":123.40075980000006,"Y":0},"Distance":1000000,
# "MapSize":"\"larger\"","LevelIDs":"3,2","Bounds":{"NorthEast":{"X":180,"Y":0},
# "SouthWest":{"X":-18,"Y":15}},"IpAddress":"202.58.193.82"}

# X 123 -> 180, Y -> 0;
 # X -18 -> 123, Y 15 -> 0

 # "LocationGeoPoint":{"X":123.40075980000006,"Y":0},"Distance":1000000,"MapSize":"\"larger\"","LevelIDs":"3,2","Bounds":{"NorthEast":{"X":180,"Y":0},
 # "SouthWest":{"X":-18,"Y":-15}},"IpAddress":"202.58.193.82"}
