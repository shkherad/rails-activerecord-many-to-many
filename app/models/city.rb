class City < ActiveRecord::Base
  has_many :people, through: :addresses
  has_many :addresses
end
