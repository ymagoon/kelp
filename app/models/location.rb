class Location < ApplicationRecord
  belongs_to :training_organization, optional: true
  belongs_to :dive_center, optional: true
end
