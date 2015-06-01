class MovieSerializer < ActiveModel::Serializer

  # explictly list the resource attributes we want to expose
  # via our API.
  attributes :id, :name, :rating, :desc, :length, :review_count

  has_many :reviews

  # return a count of movie reviews
  # review_count is a virtual attribute. It DOES NOT EXIST
  # in the DB or in the Movie model.
  # We create in ONLY when we to the
  # render json: @movie in the MoviesController
  def review_count
    # object is the the current movie we're representing
    object.reviews.count
  end
end