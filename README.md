![General Assembly Logo](http://i.imgur.com/ke8USTq.png)

## Objectives

## Code Along: Setup

**Make sure you fork, clone, create the DB, migrate and seed the DB.**

```
rake db:create
rake db:migrate
rake db:seed
```

**Run the server**

```
rails server
```
## Code Along: Use ActiveModel Serializer to create the JSON Representation.

We typically want to have more control over the API. For example, we don't want to show the created_at and updated_at attributes for each model. 

The most common way to do this in a Rails API is to use the [ActiveModel Serializer](https://github.com/rails-api/active_model_serializers/tree/0-9-stable) gem. 

This will create a class for each resource that will determine the *representation* of the resource.

**Add this to the Gemfile, and bundle install.**

```
gem 'active_model_serializers'
```

**Add this to the app/controller/application_controller.rb**

```
	# Remove the root element, curly braces surrounding the JSON.                                                     
  def default_serializer_options
    {
      root: false
    }
  end
```

### Create the JSON Representation of a Movie

**Add this to the app/serializers/movie_serializer.rb**

```
class MovieSerializer <	ActiveModel::Serializer
  attributes :id, :name, :rating, :desc, :length
end
```

Now look at the Movies JSON and notice that its missing the created_at and updated_at attributes. *Because they weren't included in the attributes above.*

**Add this to the app/serializers/movie_serializer.rb**

```
  ...
  has_many :reviews
  ...
```

**Go to /movies and /movies/2**

Now when we view movies we'll see all it's reviews embedded in the view for movie!

But, we can see ONLY the reviews for a movie by going to *http://localhost:3000/movies/2/reviews*. 

See the difference? We may not need both of these, depends on what the client wants.

### Create the JSON Representation of a Review.

Lets create a representation of a Review. Again, we don't want the created_at and updated_at attributes.

**Add the below to app/serializers/review_serializer.rb**

```
class ReviewSerializer < ActiveModel::Serializer
  attributes :name, :comment, :id
end
```

Doneso, good.

### Create an attribute only for the JSON Representation.

Add a review_count to attribute for Movies.

```
class MovieSerializer < ActiveModel::Serializer
  attributes :id, :name, :rating, :desc, :length, :review_count

  has_many :reviews

  def review_count
    object.reviews.count
  end
end
```

Notice that we added an attribute, :review_count, and a getter method for that attribute. 

The object in the review_count method references a specific movie object.

## Lab 

Add ActiveModel Serializers for the Album and Song resources. 

## Code Along: Create a User 

Now we want to create a User model. This user will be the person that creates the movie review. 

All reviews must be created by a user.

#### Create a User model

```
rails g model User name email
```

This will generate a User model and migration.

#### Create a JOIN model/table 

Each user may have many reviews. *This is a one to many relationship*.

We already had a one to many relationship before. A movie may have many reviews.

Now, we want to create a Many to Many relationship between Movies and Users. A User may review many movies and a Movie may have been reviewed by many users.

**Create a migration that will add a foreign key, user_id, to the reviews table.**

```
rails d migration MakeReviewsAJoinTable
```

**In the migration generated.**

```ruby
class MakeReviewsAJoinTable < ActiveRecord::Migration
  def up
    add_column :reviews, :user_id, :integer
    remove_column :reviews, :name
  end

  def down
    add_column :reviews, :name, :string
    remove_column :reviews, :name
  end
end

```

This will create a user_id column in the reviews table that will be used as a **foreign key** to the users table.

Remove the name column from the reviews table. *We no longer need the name because we have a user.*.

*Notice the up and down methods. These will be used for running a migration, up, and rolling back a migration, down.*

#### Create a has many relationship from the User to the Review model.

**Add this to the User model.**

```ruby
has_many :reviews
```

#### Create a belongs to relationship from the Review to the User model.

**Add this to the Review model**

```ruby
belongs_to :user

```


#### Update the seed file

```ruby
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
```

**Drop, Create, Migrate and Seed the DB.**

```
rake db:reset
```

### Check seed data in the Rails console

## Code Along: Has Many Through

#### Find the movies a user has reviewed.

Now that we have a JOIN table/model we can go **through** it to get the movies a user has created a review for. 

```ruby
class User ...
 has_many :movies, through: :reviews
end
```

This will use the join model to get the movies a user has reviewed.

**In the rails console**

```ruby

tom = User.find_by_name("Tom")
tom.movies

...

joanne = User.find_by_name("Joanne")
joanne.movies
```

Notice the SQL that the `tom.movies` and `joanne.movies` generates and executes.

```sql
 SELECT "movies".* FROM "movies" INNER JOIN "reviews" ON "movies"."id" = "reviews"."movie_id" WHERE "reviews"."user_id" = $1
```

#### Find the users that have reviewed a movie.

Now, let's see who have reviewed a specific movie.

**Add this to the movie model.**

```ruby
class Movie < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews
end
```

Here we've added `has_many :users, through: :reviews`. 

**In the rails console**

```ruby

m1 = Movie.first
m1.users

...
 m1.users.map(&:name)
```

The `m1.users` returns an array of all the users that have reviewed the movie.

*`m1.users.map(&:name)` just gets the names of all the users that have reviewed the movie. It uses the Ruby symbol to proc notation, `&:<attribute name>`.*

*The above is shorthand for this.*

```ruby
movie_reviewers = m1.users
movie_reviewers.map{ |reviewer| reviewer.name }
```

## References

* [Rails Documentation](http://api.rubyonrails.org/)

* [Debugging Rails with the byebug Gem](http://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-byebug-gem)

* [With So Much Rails to Learn, Where Do You Start?](http://www.justinweiss.com/blog/2015/05/25/with-so-much-rails-to-learn/?utm_source=rubyweekly&utm_medium=email)

* [ActiveRecord Basics](http://guides.rubyonrails.org/active_record_basics.html)



