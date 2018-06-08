class DcTwo < ApplicationRecord
  # belongs_to :location
  has_many :agency_twos
  # has_many :training_organizations, through: :agencies
end
