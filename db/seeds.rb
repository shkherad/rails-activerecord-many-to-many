Album.delete_all

nevermind = Album.create!(title: "Nevermind", genre: 'rock')
sea_change = Album.create!(title: "Sea Change", genre: 'jazz')

sea_change.songs.create!(title: 'golden age', price: 1.99, duration: 215)
sea_change.songs.create!(title: 'lost Cause', price: 4.99, duration: 182)
sea_change.songs.create!(title: 'lonesome Tears', price: 2.99, duration: 156)

nevermind.songs.create!(title: 'lithium', duration: 193, price: 1.99)
nevermind.songs.create!(title: 'come as you are', duration: 177, price: 1.49)
