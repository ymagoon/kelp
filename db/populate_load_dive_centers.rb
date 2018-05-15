# Countries are important because the file contains latlng values for each country. This code is going to
# loop over every country and scrape the data at the API endpoint by loading in each countries' latlng parameters
def populate_load_dive_centers(type)
  dir = File.dirname(__FILE__)
  raw_json = File.open(File.join(dir, "seeds/countries.json")).read
  parsed_json = JSON.parse(raw_json)

  if type == 'scrape'
    base_url = "https://my.divessi.com/code/geo/dc.json.php?"

    # The code below is important because there are ~2700 dive centers in SSI's database. Scraping all
    # of them at once without any issues (including network issues or Google Geocoding API daily request quota) is
    # essentially impossible. Thus, the code below exists to load all dive centers with their store number, lat, and lng
    # into a temporary load_dive_centers table. After each record is actually added to the dive_centers table, it is
    # inactivated from load_dive_centers. This allows us to begin right back where we left off in the event of an issue

    i = 1
    parsed_json.each do |country|
      url = "#{base_url}latitude=#{country['latlng'][0]}&longitude=#{country['latlng'][1]}&zoom=1&searchTerm=&searchCat=&searchCountry="
      puts "parsing #{country['name']['common']}..."
      puts "country #{i} of #{parsed_json.count}"
      data = JSON.parse(RestClient.get(url))

      data['markers'].each do |center|
        attributes = { store_number: center['f'].to_i,
                       lat: center['la'].to_f,
                       lng: center['lo'].to_f,
                       agency_type: set_agency_type(center['t']) }
        LoadDiveCenter.create(attributes)
      end
      i += 1
    end
  elsif type == 'file'
    #scrape from json file
  end
end
