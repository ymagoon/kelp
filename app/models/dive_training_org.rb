class DiveTrainingOrg < ApplicationRecord
  belongs_to :location
  has_many :dive_center_orgs
  has_many :dive_centers, through: :dive_center_orgs

  validates :short_name, uniqueness: true, presence: true
  validates :long_name, uniqueness: true, presence: true
end
