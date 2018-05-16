# This script takes all of the data from load_dive_centers and loops through it to populate dive_centers
# All active dive centers that still need to be loaded into dive_centers will have active_ind = 1
def populate_ssi_dive_centers
  load_dive_centers = LoadDiveCenter.where(active_ind: 1)
  training_org = TrainingOrganization.find_by(short_name: 'SSI')

  size = load_dive_centers.size

  load_dive_centers.each_with_index do |dc, index|
    puts "#{index} of #{size} dc #{dc.store_number}..."
    dco_attributes = { store_number: dc.store_number, training_organization: training_org }

    puts 'scraping DC....'
    dc_hash = scrape_ssi_dive_centers(dc.store_number)

    dc_hash[:dive_center_type] = set_dive_center_type(dc.dive_center_type)

    puts 'finding address...'

    address_json = find_address(dc.lat, dc.lng)

    # Added to ensure I'm not adding shit addresses to the DB
    if address_json[1] == 'OK'
      loc_attributes = parse_google_geocode(address_json)
    elsif address_json[1] == 'OVER_QUERY_LIMIT'
      puts 'over query limit for google geocode api...'
      break
    end

    loc_attributes[:lat] = dc.lat
    loc_attributes[:lng] = dc.lng

    puts 'creating location...'
    loc_attributes[:source] = 'SSI'
    loc = Location.create!(loc_attributes)

    dc_hash[:location] = loc

    ap dc_hash
    puts 'creating dc...'
    dco_attributes[:dive_center] = DiveCenter.create!(dc_hash)

    puts 'creating dco...'
    dco = Agency.create!(dco_attributes)

    puts 'updating load_dive_center...'

    dc.update(active_ind: 0)
  end
end
