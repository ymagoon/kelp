class Agency < ApplicationRecord
  belongs_to :dive_center
  belongs_to :training_organization

  validates :store_number, presence: true
end
