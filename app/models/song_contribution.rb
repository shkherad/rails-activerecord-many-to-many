# == Schema Information
#
# Table name: song_contributions
#
#  id        :integer          not null, primary key
#  song_id   :integer
#  artist_id :integer
#  role      :string
#

class SongContribution < ActiveRecord::Base

  belongs_to :artist
  belongs_to :song
end
