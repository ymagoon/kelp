def scrape_padi_dive_centers
  dive_centers = []

  # Loop over all latitudes
  c_lat = 90
  while c_lat => 90
    if c_lat <= 80 && c_lat >= -80
      n_lat = c_lat + 10
    elsif c_lat >= 90
      n_lat = 90
    else
      n_lat = -90
    end

    s_lat = c_lat >= -80 ? c_lat - 10 : -90

    # c_lat += 20 to do

    c_lng = -170
    18.times do
      # e_lng = c_lng + 10
      # w_lng = c_lng - 10
      puts "loop is at latlng #{c_lat},#{c_lng}"

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
          dive_center = {}
          dive_center[:store_number] = dc['StoreNumber']
          dive_center[:name] = dc['StoreName']
          dive_center[:address_1] = dc['Address1']
          dive_center[:address_2] = dc['Address2']
          dive_center[:city] = dc['City']
          dive_center[:state] = dc['State']
          dive_center[:postal_code] = dc['Zip']
          dive_center[:country] = dc['Country']
          dive_center[:primary_phone] = dc['Phone']
          dive_center[:website] = dc['Web']
          dive_center[:fax] = dc['Fax']
          dive_center[:email] = dc['Email']
          dive_center[:lat] = dc['Latitude']
          dive_center[:lng] = dc['Longitude']
          dive_center[:agency_type] = dc['CredentialCode'] #finish
          dive_center[:fb] = dc['FB']
          dive_center[:twitter] = dc['Twitter']
          dive_center[:youtube] = dc['YouTube']
          dive_center[:google] = dc['Google']
          dive_center[:linkedin] = dc['LinkedIn']
          dive_center[:blog] = dc['Blog']
          dive_center[:tripadvisor] = dc['TripAdvisor']

          dive_centers << dive_center
        end
      end
      c_lng += 20
    end
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
