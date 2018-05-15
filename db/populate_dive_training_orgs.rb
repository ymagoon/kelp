def populate_dive_training_orgs
  # Load all of the organizations that provide licensing for diving and load them into dive_training_orgs

  dir = File.dirname(__FILE__)
  raw_json = File.open(File.join(dir, "seeds/dive_training_orgs.json")).read
  parsed_json = JSON.parse(raw_json)

  parsed_json.each do |short_name, org|
    loc = Location.create(address_1: "#{org['street_number'] } #{org['street_short_name']}",
                           city: org['city_short_name'],
                           state: org['state_long_name'],
                           country: org['country_long_name'],
                           postal_code: org['postal_code'],
                           source: org['source'])

    puts 'loc created, creating dive_training_org...'

    DiveTrainingOrg.create(short_name: short_name,
                                    long_name: org['long_name'],
                                    location: loc,
                                    primary_phone: org['primary_phone'],
                                    website: org['website'],
                                    email: org['email'])
  end
end
