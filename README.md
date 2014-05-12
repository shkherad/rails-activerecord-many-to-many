# Harry Potter Relations Lab

In the world of Harry Potter, each school (such as Hogwarts) has many Houses, which each have many students. Any given student can only belong to one house.

We want to create an application where you can browse through schools, houses, students and their relationships. Later this afternoon, we'll add in spells and courses.

## Part 1: has_many

Use has_many relationships to model the relationships between School, House and Student

Use the `seeds.rb` file to create a set of schools, houses and students. Don't worry about implementing create/edit for houses or schools, but allow for the creation, deletion and editing of students.


## Part 2: has_many through

Each student takes many courses (we're using this word to describe them since 'class' is a reserved word in Ruby) and also can cast many spells. But these aren't owned only by one student, but used by many! For this we'll have to implement has_many through for each of them.

Students have many Courses through Schedules.

Students have many Spells through Knowledge.

Create the CRUD methods needed to make new Courses and Spells. Then add an interface (checkboxes are a great way to do this) to the Edit screen on Students to update their Courses and Spells. You don't create interfaces around Schedules or Knowledge.

### Optional

Use RSpec to make this process even better. It might be harder up-front, but your code will probably be better!


