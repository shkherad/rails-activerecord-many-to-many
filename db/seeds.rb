User.destroy_all
Review.destroy_all
Movie.destroy_all

tom = User.create!(name: 'Tom')
joanne = User.create!(name: 'Joanne')
meg = User.create!(name: 'Meg')

movie = Movie.create!(name: 'Affliction', rating: 'R', desc: 'Little Dark', length: 123)
movie.reviews.create!(user: tom, comment: 'Dark, somber')
movie.reviews.create!(user: meg, comment: 'Slow, boring')

movie = Movie.create!(name: 'Mad Max', rating: 'R', desc: 'Fun, action', length: 154)
movie.reviews.create!(user: tom, comment: 'Explosions, silly')
movie.reviews.create!(user: joanne, comment: 'Brilliant, fun')

movie = Movie.create!(name: 'Rushmore', rating: 'PG-13', desc: 'Quirky humor', length: 105)
movie.reviews.create!(user: tom, comment: 'Crazy, humor')
movie.reviews.create!(user: joanne, comment: 'Waste of time, stupid')

puts "Created three Movies"

Song.delete_all
Album.delete_all

###### Nevermind #######
teen_spirit = Song.create!(title: 'Teen Spirit', price: 1.49, duration: 301)
lithium = Song.create!(title: 'Lithium', price: 1.99, duration: 237)

nevermind = Album.create!(title: 'Nevermind', year: 1991)
nevermind.songs << teen_spirit
nevermind.songs << lithium

###### Sea Change #######
golden_age = Song.create!(title: 'Golden Age', price: 1.00, duration: 273)
lost_cause = Song.create!(title: 'Lost Cause', price: 1.99, duration: 227)

sea_change = Album.create!(title: 'Sea Change', year: 2002)
sea_change.songs << golden_age
sea_change.songs << lost_cause

puts "Create 2 Albums, each with two songs"
