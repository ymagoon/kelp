require_relative 'populate_dive_training_orgs'
require_relative 'populate_sditdi_dive_centers'
require_relative 'helper'

# populate_dive_training_orgs
populate_sditdi_dive_centers

populate_load_dive_centers('file')
