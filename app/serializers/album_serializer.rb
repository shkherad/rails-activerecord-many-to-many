class AlbumSerializer < ActiveModel::Serializer
  attributes :title, :year, :id, :num_of_songs, :price

  has_many :songs

  def price
    "$#{object.price.round(2)}"
  end

  def num_of_songs
    object.songs.count
  end

end