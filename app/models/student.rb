class Student < ActiveRecord::Base
  belongs_to :house

  has_many :knowledges
  has_many :spells, through: :knowledges

  has_many :schedules
  has_many :courses, through: :schedules
end
