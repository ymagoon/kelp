class TrainingOrganization < ApplicationRecord
  belongs_to :location
  has_many :agencies
  has_many :dive_centers, through: :agencies

  validates :short_name, uniqueness: true, presence: true
  validates :long_name, uniqueness: true, presence: true
end
