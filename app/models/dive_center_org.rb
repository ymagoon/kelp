class DiveCenterOrg < ApplicationRecord
  belongs_to :dive_center
  belongs_to :dive_training_org

  validates :store_number, presence: true
end
