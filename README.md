![General Assembly Logo](http://i.imgur.com/ke8USTq.png)

# Rails ActiveRecord: many-to-many relationships

Now that we understand one-to-many relationships using ActiveRecord's `has_many`
 and `belongs_to`, we'll look at how to manage many-to-many relationships using
 the same two macros.
The difference is we'll be using the `through` option for `has_many`, creating a
 join table and supporting model if they do not exist, and using `belongs_to`
 twice on the join model.

## Objectives

-   Diagram a many-to-many relationship using an ERD.
-   Write a migration for a many-to-many relationship.
-   Configure ActiveRecord to manage many-to-many relationships.
-   Create associated records using the rails console.

## Instructions

Fork, clone, branch (training), and `bundle install`.

Next, create your database, migrate, and seed.

Follow along with your instructor, closing your laptop if requested.

## Exercise: ERDs

Suppose we have `Person`, `City`, and `Address`.
We want to set up two relationships, a one-to-many relationship between `Person`
 and `Address`, and a one-to-many relationship between `City` and `Address`.

Diagram these two relationships using an ERD.
You should have three entities and two relationships.
Using ActiveRecord, we will be able to access `City` from `Person` and
 vice-versa.
Draw an additional dotted line to represent this "pseudo"-relationship.

## Exercise: Join Table Migration

Generate a model and migration for `addresses`.
`addresses` should have references to both `person` and `city`.

After you generate the migration, inspect it visually and if it looks right, run
 `rake db:migrate`.
Next enter `rails db` and inspect the `addresses` table with `\d addresses`.
Do the columns look as you'd expect? Your output should resemble:

```text
                           Table "public.addresses"
  Column   |  Type   |                       Modifiers
-----------+---------+--------------------------------------------------------
 id         | integer                     | not null default nextval('addresses_id_seq'::regclass)
 category   | character varying           |
 person_id  | integer                     |
 city_id    | integer                     |
 created_at | timestamp without time zone | not null
 updated_at | timestamp without time zone | not null
Indexes:
    "addresses_pkey" PRIMARY KEY, btree (id)
    "index_addresses_on_person_id" btree (person_id)
    "index_addresses_on_city_id" btree (city_id)
Foreign-key constraints:
    "fk_rails_82bb5e9003" FOREIGN KEY (city_id) REFERENCES cities(id)
    "fk_rails_e760e37e14" FOREIGN KEY (person_id) REFERENCES people(id)
```

If you need to make changes to your migration, run `rake db:rollback`, edit the
 migration, and re-run `rake db:migrate`.
If you get stuck, as a last resort you can nuke and pave:

```sh
rake db:drop db:create db:migrate db:seed
```

## Rails: `has_many :through`

Since we are continuing to use `has_many`, the methods that are generated on our
 models are the same as before.
See [ActiveRecord::Associations::ClassMethods documentation](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-has_many)
 for a complete list.

The difference is that this time, we are associating with a join table that
 should have an associated join model.
To be able to access things as we'd expect, we should include both a `has_many`
 and `has_many through:` on the source model.

### Code along: Creating Associated Records

We need to set up ActiveRecord to handle our many-to-many relationship from
 `Person` to `City`. Open `app/models/person.rb` and edit it.

```ruby
class Person < ActiveRecord::Base
  has_many :cities, through: :addresses
  has_many :addresses
end
```

Where do we include our `inverse_of` option?
On the join model.
We'll be including two `belongs_to` associations on the join model, so let's
 hold off on creating `app/models/address.rb`.

Let's open `app/models/city.rb` and edit it.

```ruby
class City < ActiveRecord::Base
  has_many :people, through: :addresses
  has_many :addresses
end
```

Next, create `app/models/address.rb`.

```ruby
class Address < ActiveRecord::Base
  belongs_to :person, inverse_of: :addresses
  belongs_to :city, inverse_of: :addresses
end
```

Enter `rails db`. Query the `addresses` table. It should be empty.

Exit and then enter `rails console`.

```ruby
joan = Person.first
boston = City.find_by city: 'Boston', region: 'MA'
dc = City.find_by city: 'Washington', region: 'DC'

joan.cities << dc
joan.cities << boston

joan.cities
joan.addresses
```

Exit and re-enter `rails db`.
Query the `addresses` table, the `people` table, and the `cities` table.
What do you expect to see? Are your expectations met?

### Lab: Creating Associated Records

Create a model and migration for `companies` using the first line of
 `data/companies.csv` for the attribute names.
Inspect your migration, run `rake db:migrate`, and check the results in
 `rails db`.
Add companies to the populate task and load them.

Create a model and migration for `jobs`.
`jobs` should reference both a `person` and a `company`, and have a `start_on`
 date, `end_on` date and a `salary` stored as an integer.
Inspect your migration, run `rake db:migrate`, and check the results in
 `rails db`.

Create a many-to-many relationship between `Person` and `Company` through
 `Job`.
Test your work by associating a person with two companies
 from the `rails console`.
Inspect the results in `rails db`.

## Best Practice

Never use `has_and_belongs_to_many`. Always choose `has_many through:`.
It is more expensive to change from the former to latter than to create a simple
 model and join table from the beginning.

## Resources

-   [Active Record Associations — Ruby on Rails Guides](http://guides.rubyonrails.org/association_basics.html#choosing-between-has-many-through-and-has-and-belongs-to-many)
 (bad advice)
-   [Why You Don’t Need Has_and_belongs_to_many Relationships << Flatiron School](http://blog.flatironschool.com/why-you-dont-need-has-and-belongs-to-many/)
 (good advice)
-   [has_many :through - Many-to-many Dance-off!](http://blog.hasmanythrough.com/2006/4/20/many-to-many-dance-off)
-   [Craic Computing Tech Tips: Migrating from Rails HABTM to has_many :through](http://craiccomputing.blogspot.com/2013/06/migrating-from-rails-habtm-to-hasmany.html)

## [License](LICENSE)

Source code distributed under the MIT license. Text and other assets copyright
General Assembly, Inc., all rights reserved.
