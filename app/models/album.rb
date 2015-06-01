class Album < ActiveRecord::Base
  has_many :songs

  # virtual attribute
  # What is a virtual attribute
  def price
  #     songs.sum(&:price)/2

    total = 0
    songs.each do |song|
      total = total + song.price
    end
    total/2
  end
end
