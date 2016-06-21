class Person < ActiveRecord::Base
  has_many :cities, through: :addresses
  has_many :addresses
  has_many :skills, through: :endorsments
  has_many :endorsments
  has_many :companies, through: :jobs
  has_many :jobs
end
