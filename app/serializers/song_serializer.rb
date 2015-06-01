class SongSerializer < ActiveModel::Serializer

  attributes :title, :duration, :price, :id
end