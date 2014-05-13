class Student < ActiveRecord::Base
  belongs_to :house

  has_many :knowledges
  has_many :spells, through: :houses
end
