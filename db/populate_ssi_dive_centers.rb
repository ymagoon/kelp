def populate_ssi_dive_centers
  # All active dive centers that still need to be loaded into dive_centers will have active_ind = 1
  load_dive_centers = LoadDiveCenter.where(active_ind: 1)
  agency = DiveTrainingOrg.find_by(short_name: 'SSI')

  load_dive_centers.each do |dc|
    dco_attributes = { store_number: dc.store_number, dive_training_org: agency }
    loc_attributes = {}

    puts 'scraping DC....'
    dc_hash = scrape_ssi_dive_centers(dc.store_number)

    dc_hash[:agency_type] = set_agency_type(dc.agency_type)

    puts 'finding address...'
    loc_attributes[:lat] = dc.lat
    loc_attributes[:lng] = dc.lng

    address_json = find_address(loc_attributes[:lat], loc_attributes[:lng])
    loc_attributes = parse_google_geocode(address_json)

    puts 'creating location...'
    loc_attributes[:source] = 'SSI'
    loc = Location.create!(loc_attributes)

    dc_hash[:location] = loc

    ap dc_hash
    puts 'creating dc...'
    dco_attributes[:dive_center] = DiveCenter.create!(dc_hash)

    puts 'creating dco...'
    dco = DiveCenterOrg.create!(dco_attributes)

    puts 'updating load_dive_center...'

    dc.update(active_ind: 0)
  end
end
