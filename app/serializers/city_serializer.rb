class CitySerializer < ActiveModel::Serializer
  attributes :id, :population, :name, :country, :region, :longitude, :latitude, :people
end
