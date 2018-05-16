class LoadDiveCenter < ApplicationRecord
  validates :store_number, uniqueness: true

  def self.active?
    @dive_centers = self.where(active_ind: 1)
  end
end
