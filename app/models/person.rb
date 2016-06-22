class Person < ActiveRecord::Base
  has_many :addresses
  has_many :cities, through: :addresses

  has_many :companies, through: :jobs
  has_many :jobs

  has_many :skills, through: :endorsements
  has_many :endorsements
end
