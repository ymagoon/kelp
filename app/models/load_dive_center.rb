class LoadDiveCenter < ApplicationRecord
  validates :store_number, uniqueness: true
end
