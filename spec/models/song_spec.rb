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

require 'rails_helper'

RSpec.describe Song, :type => :model do
  let(:album) { Album.create(title: 'album1', genre: 'rock') }
  subject { album.songs.new(title: 'song1', duration: 199, price: 2.99) }

  it "should create a valid song" do
    expect(subject.title).to eq 'song1'
    expect(subject.duration).to eq 199
    expect(subject.price).to be_within(0.001).of(2.99)
  end

  it "should not allow a song without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "should not allow a song without a duration less than 30 seconds" do
    subject.duration = 29
    expect(subject).to_not be_valid
  end

  it "should not allow a song without a duration greater than 1200" do
    subject.duration = 1200
    expect(subject).to_not be_valid
  end

  it "should allow a song without a duration greater than 30 and less than 1200 seconds" do
    expect(subject).to be_valid
    subject.duration = 1199
    expect(subject).to be_valid
  end

  it "should not allow a valid subject that does not belong to an album" do
    song = Song.new(title: 'song1', duration: 199, price: 2.99)
    expect{song.save!}.to raise_error(ActiveRecord::RecordInvalid, /Album can't be blank/)
  end

end
