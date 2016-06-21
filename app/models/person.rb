class Person < ActiveRecord::Base
  has_many :cities, through: :addresses
  has_many :addresses
end
