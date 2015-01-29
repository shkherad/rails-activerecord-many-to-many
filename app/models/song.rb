class Song < ActiveRecord::Base
  validates :title, presence: true
  belongs_to :album
end
