require_relative 'scripts/add_missing_location'
require_relative 'scripts/populate_training_organizations'
require_relative 'scripts/populate_load_dive_centers'
require_relative 'scripts/populate_sditdi_dive_centers'
require_relative 'scripts/populate_ssi_dive_centers'
require_relative 'scripts/scrape_ssi_dive_centers'
require_relative 'scripts/populate_dive_centers'
require_relative 'scripts/helper'

# add_missing_location
# populate_dive_centers
# populate_training_organizations #
# populate_load_dive_centers('file') #
# populate_sditdi_dive_centers #
populate_ssi_dive_centers
