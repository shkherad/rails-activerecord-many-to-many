class Song < ActiveRecord::Base
  belongs_to :album
  validates :album, presence: true
  validates :title, presence: true
  validates_numericality_of :price, greater_than_or_equal_to: 0, less_than: 10
  validates_numericality_of :duration, greater_than_or_equal_to: 30, less_than: 1200
end
