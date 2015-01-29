Album.delete_all
Song.delete_all

nevermind = Album.create!(name: "Nevermind", genre: 'rock')
sea_change = Album.create!(name: "Sea Change", genre: 'jazz')

nevermind.songs << Song.create(title: "Smells like Teen Spirit", artist: 'Nirvana', duration: 183, price: 1.99)
nevermind.songs << Song.create(title: "In Bloom", artist: 'Nirvana', duration: 145, price: 2.99)
nevermind.songs << Song.create(title: "Lithium", artist: 'Nirvana', duration: 145, price: 1.49)

sea_change.songs << Song.create(title: "Golden Age", artist: 'Beck', duration: 203, price: 0.99)
sea_change.songs << Song.create(title: "Lost Cause", artist: 'Beck', duration: 177, price: 3.99)
sea_change.songs << Song.create(title: "Lonesome Tears", artist: 'Beck', duration: 193, price: 1.49)
