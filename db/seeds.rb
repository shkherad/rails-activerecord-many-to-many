Song.delete_all
Album.delete_all

nevermind = Album.create!(title: "Nevermind", genre: 'rock')
sea_change = Album.create!(title: "Sea Change", genre: 'jazz')

golden_age = sea_change.songs.create!(title: 'golden age', price: 1.99, duration: 215)
lost_cause = sea_change.songs.create!(title: 'lost Cause', price: 4.99, duration: 182)
lonesome_tears = sea_change.songs.create!(title: 'lonesome Tears', price: 2.99, duration: 156)

lithium = nevermind.songs.create!(title: 'lithium', duration: 193, price: 1.99)
come_as = nevermind.songs.create!(title: 'come as you are', duration: 177, price: 1.49)

Artist.delete_all
SongContribution.delete_all

kurt = Artist.create!(name: 'Kurt Cobain', dob: DateTime.parse("February 20, 1967") )
dave = Artist.create!(name: 'Dave Grohl', dob: DateTime.parse("January 14, 1969"))
beck = Artist.create!(name: 'Beck Hansen', dob: DateTime.parse("July 8, 1970"))


# Add songs to artists
kurt.song_contributions.create!(song: come_as, role: 'writer')
# Explicity create a SongContribution, pretty much same as above
SongContribution.create!(song: lithium, artist: kurt, role: 'guitar')

beck.song_contributions.create!(song: lost_cause, role: 'writer')
beck.song_contributions.create!(song: lonesome_tears, role: 'singer')
beck.song_contributions.create!(song: golden_age, role: 'writer')

# Add artists to a songs.
lithium.song_contributions.create(song: lithium, role: 'drummer')
lithium.song_contributions.create(song: come_as, role: 'drummer')
