# Populates dive_centers with all dive centers in a json file called dive_centers.json
# This file can contain dive centers from all TrainingOrganizations
def populate_dive_centers
  json = open_parse_json('../data/dive_centers.json')

  size = json.size
  json.each_with_index do |dc, index|
    puts "dive center #{index} of #{size}"
    dive_center = {}

    dive_center[:name] = dc['name']
    dive_center[:primary_phone] = dc['primary_phone']
    dive_center[:mobile_phone] = dc['mobile_phone']
    dive_center[:website] = dc['website']
    dive_center[:email] = dc['email']
    dive_center[:fax] = dc['fax']
    dive_center[:tripadvisor] = dc['tripadvisor']
    dive_center[:fb] = dc['fb']
    dive_center[:twitter] = dc['twitter']
    dive_center[:youtube] = dc['youtube']
    dive_center[:google] = dc['google']
    dive_center[:linkedin] = dc['linkedin']
    dive_center[:blog] = dc['blog']
    dive_center[:project_aware] = dc['project_aware']
    dive_center[:dive_center_type] = dc['agency_type']
    dive_center[:location] = Location.new(source: 'seed') # fix

    dive_center = DiveCenter.create!(dive_center)
    training_organization = TrainingOrganization.find(dc['dive_training_org_id'])

    puts "creating agency #{dc['store_number']}..."
    Agency.create(store_number: dc['store_number'],
                  training_organization: training_organization,
                  dive_center: dive_center)
  end
end
