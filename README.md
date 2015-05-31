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

## References

* [Rails Documentation](http://api.rubyonrails.org/)

* [Debugging Rails with the byebug Gem](http://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-byebug-gem)

* [With So Much Rails to Learn, Where Do You Start?](http://www.justinweiss.com/blog/2015/05/25/with-so-much-rails-to-learn/?utm_source=rubyweekly&utm_medium=email)

* [ActiveRecord Basics](http://guides.rubyonrails.org/active_record_basics.html)



