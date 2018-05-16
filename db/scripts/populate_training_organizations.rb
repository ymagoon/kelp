# Load all of the organizations that provide licensing for diving and load
# them into dive_training_orgs
def populate_training_organizations
  json = open_parse_json('../data/dive_training_orgs.json')

  json.each do |short_name, org|
    loc = Location.create(address_1: "#{org['street_number'] } #{org['street_short_name']}",
                           city: org['city_short_name'],
                           state: org['state_long_name'],
                           country: org['country_long_name'],
                           postal_code: org['postal_code'],
                           source: org['source'])

    puts 'loc created, creating dive_training_org...'

    TrainingOrganization.create(short_name: short_name,
                                long_name: org['long_name'],
                                location: loc,
                                primary_phone: org['primary_phone'],
                                website: org['website'],
                                email: org['email'])
  end
end
