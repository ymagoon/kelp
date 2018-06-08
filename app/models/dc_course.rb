class DcCourse < ApplicationRecord
  belongs_to :course
  belongs_to :dive_center
end
