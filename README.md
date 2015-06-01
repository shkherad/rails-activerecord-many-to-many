![General Assembly Logo](http://i.imgur.com/ke8USTq.png)

## Objectives
* Use ActiveModel Serializer to create the JSON Representation of a Resource.
* Create a Join Model for a Many-To-Many Relationship.
* Use Rails has_many :through to implement a Many-To-Many Relationship.
* Emulate a logged-in user to show a user's movie reviews.

## Code Along: Setup

**Fork and clone. Then create the DB, migrate and seed the DB.**

```
rake db:create
rake db:migrate
rake db:seed
```

**Run the server**

```
rails s
```
## Code Along: Use ActiveModel Serializer to create the JSON Representation.

We typically want to have more control over the API. For example, we don't want to show the `created_at` and `updated_at` attributes for each model. Or we may want to create an attribute that doesn't exist on a Model.

The most common way to do this in a Rails API is to use the [ActiveModel Serializer](https://github.com/rails-api/active_model_serializers/tree/0-9-stable) gem. 

*Note, we are using the version 0.9 of this gem. Not the latest version as there were problems with the latest version.*

ActiveModel Serializer (AMS) will create a class for each resource, Movie and Review. This class will determine the *JSON representation* of the resource.

**Add this to the Gemfile, and bundle install.**

This will get version 0.9.3 of this gem.

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
  # determines which attributes will be shown in the represntation.
  attributes :id, :name, :rating, :desc, :length
end
```

Now look at the Movies JSON and notice that its missing the `created_at` and `updated_at` attributes. *Because they weren't included in the attributes above.*

**Add this to the app/serializers/movie_serializer.rb**

```
  ...
  has_many :reviews
  ...
```

**Go to `http://localhost:3000/movies` and `http://localhost:3000/movies/2`**

Now when we view movies we'll see all it's reviews embedded in the representation of a movie!

But, we can see ONLY the reviews for a movie by going to *http://localhost:3000/movies/2/reviews*. 

See the difference? We may not need both of these, depends on what the client wants.

### Create the JSON Representation of a Review.

Lets create a representation of a review. Again, we don't want the `created_at` and `updated_at` attributes.

**Add the below to app/serializers/review_serializer.rb**

```
class ReviewSerializer < ActiveModel::Serializer
  attributes :name, :comment, :id
end
```

Doneso, good.

### Create a virtual attribute only for the JSON Representation.

Add a review_count virtual attribute for movie representation.

```
class MovieSerializer < ActiveModel::Serializer
  attributes :id, :name, :rating, :desc, :length, :review_count

  has_many :reviews

  # create a virtual attribute
  def review_count
    object.reviews.count
  end
end
```

Notice that we added an attribute, :review_count, and a getter method for that attribute. 

The *object* in the review_count method references a specific movie object.

## Lab 

* Add ActiveModel Serializers for the Album and Song resources. Remove the `created_at` and `updated_at` attributes.

* Add a virtual attribute, num_of_songs, to the Album representation using AMS.

* Add a virtual attribute, price, to the Album model. The price of the album will be 50 percent of the price of all the album songs.


## Code Along: Create a User 

Now we want to create a User model. This user will be the person that creates the movie review. 

We'll see later how all reviews must be created by a user.

#### Create a User model

```
rails g model User name email
```

This will generate a User model and migration.

#### Create a JOIN model/table 

Each user may have many reviews. *This is a one to many relationship*.

*We already had a one to many relationship.* A movie may have many reviews.

Now, we want to create a **many to many relationship** between Movies and Users. **A user may review many movies** and a **movie may have been reviewed by many users**.

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

```ruby
tom = User.find_by_name('Tom')
tom.reviews

meg = User.find_by_name('Meg')
meg.reviews
```

## Lab

* Create an Musician Model that has a name and age.
* A Musician may have played, or contributed to, many songs.
* Implement a one to many relationship between Musician and Song.


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

Now, let's see who's reviewed a specific movie.

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

> `m1.users.map(&:name)` just gets the names of all the users that have reviewed the movie. It uses the Ruby symbol to proc notation, `&:<attribute name>`.*

> The above is shorthand for this.

>```ruby
>movie_reviewers = m1.users
>movie_reviewers.map{ |reviewer| reviewer.name }
>```

## Lab
* Create a many to many relationship between Musician and Album.
 
This will all use to see the albums a musician has played on. 

And we should see the musicians that have played on an album.


## Code Along: JSON API

**Change the review serializer to get it's name from the user that created the review.*

Remember we removed the name attribute from the Review model.

```
  def name
    object.user.name
  end
```

#### Emulate an authenticated user.

When you add login, authentication, you'll typically determine the current user by calling a current_user method in the ApplicationController. 

We don't have authentication in this app yet. But, we'll emulate it by creating a current_user method and hard coding a User.

**In the app/controllers/applicaiton_controller.rb**

```
def current_user
   @current_user ||=  User.find_by_name 'Meg'
end
```

**Change the Movies Controller to use this current_user method**

```
 # GET /movies                                                                                                     
  def index
    # all the movies                                                                                                
    if current_user
      @movies = current_user.movies.all
    else
      @movies = Movie.all
    end

    render json: @movies
  end

  # GET /movies/:id                                                                                                 
  def show
    # find one Movie by id                                                                                          
    if current_user
      @movie = current_user.movies.find(params[:id])
    else
      @movie = Movie.find(params[:id])
    end
    render json: @movie
  end
```

## References
* [Active Model Serializer (AMS) ](https://github.com/rails-api/active_model_serializers/tree/0-9-stable)

* [What is "has_many through" (Video)](http://blog.teamtreehouse.com/what-is-a-has_many-through-association-in-ruby-on-rails-treehouse-quick-tip)

* [ActiveModel Associations](http://guides.rubyonrails.org/association_basics.html)

* [Nested Associations and has_many through](http://ryandeussing.com/blog/2013/06/12/nested-associations-and-has-many-through/)

* [Setting a join model attribute](http://www.tweetegy.com/2011/02/setting-join-table-attribute-has_many-through-association-in-rails-activerecord/)

* [Query and access join model attributes](http://stackoverflow.com/questions/18799934/has-many-through-how-do-you-access-join-table-attributes)
* [Rails Documentation](http://api.rubyonrails.org/)


* [With So Much Rails to Learn, Where Do You Start?](http://www.justinweiss.com/blog/2015/05/25/with-so-much-rails-to-learn/?utm_source=rubyweekly&utm_medium=email)




