class PersonSerializer < ActiveModel::Serializer
  attributes :id, :surname, :given_name, :gender, :height, :weight, :born_on
end
