class ReviewSerializer < ActiveModel::Serializer
  attributes :comment, :id, :name

  def name
    object.user.name
  end
end
