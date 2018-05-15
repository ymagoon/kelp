def populate_sditdi_dive_centers
  # Load all SDI dive centers from a file, clean them and them load them into the dive_centers DB
  dir = File.dirname(__FILE__)
  raw_json = File.open(File.join(dir, "seeds/sdi_dive_centers.json")).read
  parsed_json = JSON.parse(raw_json)

  agency = DiveTrainingOrg.find_by(short_name: 'SDI')

  parsed_json.each_value do |center|
    dc_attributes = {}
    loc_attributes = {}

    # Create Location
    loc_attributes[:address_1] = center["address_1"]
    loc_attributes[:address_2] = center["address_2"]
    loc_attributes[:city] = clean(center["city_text"])
    loc_attributes[:state] = clean(center["state"])
    loc_attributes[:country] = clean(center["country"])
    loc_attributes[:postal_code] = clean(center["post_code"])
    loc_attributes[:lat] = center["latitude"]
    loc_attributes[:lng] = center["longitude"]
    loc_attributes[:source] = 'SDI'

    puts "creating location..."
    loc = Location.create(loc_attributes)

    # Start creating DiveCenter
    dc_attributes[:name] = clean(center["name"])

    # cleaned_website is matchdata, which means if a value exists cleaned_website will be true
    cleaned_website = clean(center["website"]).match(URL_EXPRESSION)
    dc_attributes[:website] = cleaned_website ? cleaned_website[0] : ''

    # cleaned_email is matchdata, which means if a value exists cleaned_email will be true
    cleaned_email = clean(center["primary_email"]).match(EMAIL_EXPRESSION)
    dc_attributes[:email] = cleaned_email ? cleaned_email[0] : ''

    dc_attributes[:primary_phone] = clean(center["phone_number"])
    dc_attributes[:location] = loc
    dc_attributes[:agency_type] = clean(center['agency_type'])

    puts "creating dive center..."
    dive_center = DiveCenter.create(dc_attributes)

    puts "creating dive center org..."
    DiveCenterOrg.create(store_number: center['id'],
                         dive_training_org: agency,
                         dive_center: dive_center)
  end
end
