class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :city, :region, :country, :people
end
