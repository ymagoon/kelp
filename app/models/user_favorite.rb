class UserFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :dive_center
end
