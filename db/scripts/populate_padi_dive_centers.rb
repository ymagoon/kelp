json = open_parse_json('../data/padi_dive_centers.json')
countries = open_parse_json('../data/countries.json')
countries = countries.select { |c| c['padi'] }.map { |c| [c['name']['common'], c['padi']] }.to_h

dive_centers = []
padi = TrainingOrganization.find_by(short_name: "PADI")

if json['RecordCount'] != 0
  json['SearchRecords'].each do |dc|
    # if Agency.where(store_number: dc['StoreNumber']).where(training_organization: padi).empty?
      # Create DC location
      loc_attributes = {}
      loc_attributes[:source] = 'PADI'
      loc_attributes[:address_1] = dc['Address1']
      loc_attributes[:address_2] = dc['Address2']
      loc_attributes[:lat] = dc['Latitude']
      loc_attributes[:lng] = dc['Longitude']
      loc_attributes[:city] = dc['City']
      loc_attributes[:state] = dc['State']

      country = countries.select { |k, v| v.include? dc['Country'] }.keys.first

      loc_attributes[:country] = country
      puts country
      loc_attributes[:postal_code] = dc['Zip']

      puts 'creating location...'
      # loc = Location.create!(loc_attributes)

      # Create DC
      dc_attributes = {}
      # dc_attributes[:location] = loc
      dc_attributes[:location_id] = 1
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
      dc_attributes[:dive_center_type] = dc['CredentialCode'] #finish

      puts 'creating dc...'
      dive_center = DcTwo.create!(dc_attributes)

      puts 'creating agency...'
      agency = {}
      agency[:store_number] = dc['StoreNumber']
      # agency[:dive_center] = dive_center
      agency[:dc_two] = dive_center
      agency[:training_organization] = padi
      AgencyTwo.create!(agency)

      dive_centers << dive_center
    # else
    #   puts "dive center already exists...skipping #{dc['StoreNumber']}..."
    # end
  end
end
