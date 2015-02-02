class Artist < ActiveRecord::Base
  validates :name, presence: true

  has_many :song_contributions
  has_many :songs, through: :song_contributions
end
