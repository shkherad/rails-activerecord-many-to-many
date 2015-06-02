class Review < ActiveRecord::Base
  belongs_to :movie # create a setter and getter method for movie
  belongs_to :user # create a setter and getter method for user

  # def movie
  #   User.find_by_user_id(self.user_id)
  # end

  # def movie=(some_movie)
  #   @movie_id =  some_movie.movie_id
  #   save
  # end

end
