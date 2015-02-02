# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  title      :string
#  duration   :integer
#  price      :decimal(, )
#  album_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Song < ActiveRecord::Base
  belongs_to :album

  has_many :song_contributions
  has_many :artists, through: :song_contributions

  validates :album, presence: true
  validates :title, presence: true
  validates_numericality_of :price, greater_than_or_equal_to: 0, less_than: 10
  validates_numericality_of :duration, greater_than_or_equal_to: 30, less_than: 1200
end
