class Location < ApplicationRecord
  belongs_to :dive_training_org, optional: true
  belongs_to :dive_center, optional: true
end
