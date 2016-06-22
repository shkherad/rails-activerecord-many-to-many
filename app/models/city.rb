class City < ActiveRecord::Base
  has_many :addresses
  has_many :people, through: :addresses
end
