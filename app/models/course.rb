class Course < ActiveRecord::Base
  has_many :schedules
  has_many :students, through: :schedules
end
