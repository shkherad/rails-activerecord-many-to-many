class Address < ActiveRecord::Base
  belongs_to :person, inverse_of: :addresses
  belongs_to :city, inverse_of: :addresses
end
