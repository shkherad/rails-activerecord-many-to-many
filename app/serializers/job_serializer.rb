class JobSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date, :salary
  # has_one :person
  # has_one :company
end
