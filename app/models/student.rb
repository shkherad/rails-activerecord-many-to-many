class Student < ActiveRecord::Base
  belongs_to :house
  has_many :lessons # order matters!
  has_many :spells, through: :lessons
end
