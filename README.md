![General Assembly Logo](http://i.imgur.com/ke8USTq.png)

# Has Many Through (Albums, Songs, Artists)

## Objectives

By the end of this, students should be able to:

- Learn about the, often forgotton, art and science of Data Modelling.
- Learn about many to many relationships.
- Learn about how Join tables and their associated models can 
	represent relationships between entities.  
- Use Rails has_many through to construct relationship.

## Data Modeling

Data Modeling is a wonderful and well researched area of expertise. Many have spent entire careers modelling common problems that come up over and over when creating software. 

*Please remember that most problems have been solved, many, many times. And it's important to search out and understand the work of others before going off and re-inventing your own, rather oblong-ish, wheel.* 

IMO, the treasure trove of information about Data Modelling is very much under utililized. And it's area, *somewhat like functional programming*, that software developers can rediscover from the past.  


What are the cardinalities of relationships?  

* 1 - 1 relationships.  
	Usually indicates that it should be an attribute. *In rails this is a has_one and belongs_to*.    
* 1 to Many and Many to 1.  
	Make up the bulk of the relationships. *In rails this is a has_many and belongs_to*.   
* Many to Many.  
	Are almost always broken into **join** entities. *In rails this is a has_and_belongs_to_many(habtm) or has_many :through. Almost always the latter.*

>> Each \<entity\> **Must** be OR **May** be \<relationship name\> **one and only one**  OR **one or more** \<second entity\>

For example:

Each Song **must** be part of **one and only one** Album.  

* entity is Song.  
* relationship name is "part of".  
* cardinality is **one and only one**
* second entity is Album.  

Each Album **must	** contain **one or more** Songs.

* entity is Album
* relationship is "contain"
* cardinality is **one or more**
* second entity is Song.


![Entity](Album_Songs.jpg)

### References
* [How to read a Data Model](http://www.essentialstrategies.com/publications/modeling/howtoread.htm)  
* Entity Relationship Diagrams.  
	[Crows Foot Notation](http://www.tdan.com/view-articles/7474)
* This is a wonderful book to look for well thought out solutions to common problems in multiple domains.  
	[Data Model Resource Book Vol 1](http://www.amazon.com/Data-Model-Resource-Book-Vol/dp/0471380237/ref=pd_sim_b_6?ie=UTF8&refRID=115VGWZVRRY5WWCKKZRT)

* A Data Modeling Classic.  
[Data Modelling Patterns](http://www.amazon.com/Data-Model-Patterns-David-Hay/dp/0932633749)

* A 2003 book that describes how to think about designing and modelling software applications. A classic, that the Rails world discovered about 2008-9. *After Rails apps got big enough to demand design rigour*.  
	[Domain Driven Design](http://www.amazon.com/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215)

### Always, always draw a Data/Domain Model.

**Did I say always enough?**


## What we've given.

We are going to start off with a working, but limited app. What we have is a app with two models, **Song and Album**.

![Entity](Album_Songs.jpg)

## Create an Artist scaffold

```
rails g scaffold Artist name union_member:boolean dob:datetime
```

Now we have an Artist that can have a name and may be a union_member and has a Date of Birth.

By default the Artist will be a union member. *Add this to the Artist migraiton*  

```
     t.boolean :union_member, default: true
```

Migrate to add the artists table to the database.  
```
rake db:migrate
```

Create an artist in the rails console. And create, update and delete the Artist in the UI.

## Make a SongsArtist Join Table.

Now we are going to associate each Song not only with an Album, *remember each Song MUST be part of an album*, but each Song will be associated with **One or more Artists**. 

And each Artist MAY be associated with **One or more Songs.**

This is a **Many to Many** relationship between Songs and Artists. 



#### Create SongContribution model.

Create a **JOIN** model that will represent the **Many to Many** relationship between Songs and Artists.  

```
rails g migration CreateSongContribution song:belongs_to artist:belongs_to role:string
```

**Lets draw out the relationships as they will exist in the DB.**

Remove the artist field from Songs **because the this Artist to Song relationship will now be kept in the Join Table/Model.** *Don't forget to remove the artist attribute from the Song views.*  


```
rails g migration RemoveArtistFromSongs artist:string
```

Run the migrations. *May have to drop/create/migrate the DB*

```
rake db:migrate
```

Create a Join model for song contributions in app/models/song_contribution.rb  *Notice the namimg convention here*

```
class SongContribution < ActiveRecord::Base

  belongs_to :artist
  belongs_to :song

end

```

Add song contributions to the artist model.  ** We will use a through relationship to find the artist's songs!**

```
class Artist < ActiveRecord::Base

  has_many :song_contributions
  has_many :songs, through: :song_contributions
end

```

Add song contributions to the song model.  ** We will use a through relationship to find the song's artists!**

```
class Song < ActiveRecord::Base
  belongs_to :album

  has_many :song_contributions
  has_many :artists, through: :song_contributions
end
```

Add seed data.  

```
Album.delete_all

nevermind = Album.create!(title: "Nevermind", genre: 'rock')
sea_change = Album.create!(title: "Sea Change", genre: 'jazz')

golden_age = sea_change.songs.create!(title: 'golden age', price: 1.99, duration: 215)
lost_cause = sea_change.songs.create!(title: 'lost Cause', price: 4.99, duration: 182)
lonesome_tears = sea_change.songs.create!(title: 'lonesome Tears', price: 2.99, duration: 1\
56)

lithium = nevermind.songs.create!(title: 'lithium', duration: 193, price: 1.99)
come_as = nevermind.songs.create!(title: 'come as you are', duration: 177, price: 1.49)

Artist.delete_all
SongContribution.delete_all

kurt = Artist.create!(name: 'Kurt Cobain', dob: DateTime.parse("February 20, 1967") )
dave = Artist.create!(name: 'Dave Grohl', dob: DateTime.parse("January 14, 1969"))
beck = Artist.create!(name: 'Beck Hansen', dob: DateTime.parse("July 8, 1970"))

kurt.songs << lithium
kurt.songs << come_as

dave.songs << lithium

beck.songs << golden_age
beck.songs << lost_cause
beck.songs << lonesome_tears
```

#### In the Rails console.
- Take a look at each Artist's songs.
- Take a look at each Song's artists.

#### In the UI
- Take a look at each Artist's songs.
- Take a look at each Song's artists.

Oops, some work needs to be done here, ay!



