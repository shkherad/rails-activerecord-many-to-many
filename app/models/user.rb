class User < ActiveRecord::Base

  has_many :reviews
  # Find all this User's reviews 
  # It will go through the reviews table to find all the reviews.
  has_many :movies, through: :reviews  
end
