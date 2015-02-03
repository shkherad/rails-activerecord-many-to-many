class Artist < ActiveRecord::Base

  has_many :song_contributions
  has_many :songs, through: :song_contributions

  accepts_nested_attributes_for :song_contributions, :songs


  def other_songs
    Song.all - self.songs
  end
end
