class MovieSerializer < ActiveModel::Serializer
  attributes :id, :name, :rating, :desc, :length, :review_count

  has_many :reviews

  def review_count
    object.reviews.count
  end
end
