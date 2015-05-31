class ReviewSerializer < ActiveModel::Serializer
<<<<<<< HEAD
  attributes :comment, :id, :name
=======
  attributes :name, :comment, :id
>>>>>>> Emulate authentication with a current_user method

  def name
    object.user.name
  end
end
