# This should also delete all songs, all songs must be part of an album
# and has_many :songs, dependent: :destroy in Album model.
Album.delete_all

puts "Creating Albums"
nevermind = Album.create!(title: "Nevermind", genre: 'rock')
sea_change = Album.create!(title: "Sea Change", genre: 'jazz')

puts "Creating Songs for Sea Change Album"
sea_change.songs.create!(title: 'golden age', price: 1.99, duration: 215)
golden_age = sea_change.songs.create!(title: 'golden age', price: 1.99, duration: 215)
lost_cause = sea_change.songs.create!(title: 'lost Cause', price: 4.99, duration: 182)
lonesome_tears = sea_change.songs.create!(title: 'lonesome Tears', price: 2.99, duration: 156)

puts "Creating Songs for Nevermind Album"
lithium = nevermind.songs.create!(title: 'lithium', duration: 193, price: 1.99)
come_as = nevermind.songs.create!(title: 'come as you are', duration: 177, price: 1.49)

Artist.delete_all
SongContribution.delete_all

puts "Creating Artists: Kurt Cobain, Dave Grohl and Beck Hanson"
kurt = Artist.create!(name: 'Kurt Cobain', dob: DateTime.parse("February 20, 1967") )
dave = Artist.create!(name: 'Dave Grohl', dob: DateTime.parse("January 14, 1969"))
beck = Artist.create!(name: 'Beck Hansen', dob: DateTime.parse("July 8, 1970"))

puts "Kurt Cobain contributed to Lithium and Come as you are"
kurt.songs << lithium
kurt.songs << come_as

puts "Dave Grohl contributed to Lithium"
dave.songs << lithium

puts "Beck contributed to Golden Age, Lost Cause and Lonesome Tears"
beck.songs << golden_age
beck.songs << lost_cause
beck.songs << lonesome_tears
