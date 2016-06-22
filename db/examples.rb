# This file should contain all the record creation needed to experiment with
# your app during development.
#
# The data can then be loaded with the rake db:examples (or created alongside
# the db with db:nuke_pave).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# %w(antony jeff matt jason).each do |name|
#   email = "#{name}@#{name}.com"
#   next if User.exists? email: email
#   User.create!(email: email,
#                password: 'abc123',
#                password_confirmation: nil)
# end

require 'csv'

# Example data for Cities and People

City.transaction do
  CSV.foreach 'data/cities.csv', headers: true do |city|
    City.create(city.to_hash)
  end
end

Person.transaction do
  CSV.foreach 'data/people.csv', headers: true do |person|
    Person.create(person.to_hash)
  end
end

# Example data for Companies and Skills

Company.transaction do
  CSV.foreach 'data/companies.csv', headers: true do |company|
    Company.create(company.to_hash)
  end
end

Skill.transaction do
  CSV.foreach 'data/skills.csv', headers: true do |skill|
    Skill.create(skill.to_hash)
  end
end
