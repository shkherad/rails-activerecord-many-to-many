require 'csv'

namespace :db do
  namespace :populate do
    desc 'Fill the database with example data'
    task all: [:people, :cities] # Add these when ready - :companies, :skills

    desc 'Fill the people table with example data'
    task people: :environment do
      Person.transaction do
        CSV.foreach(Rails.root + 'data/people.csv',
                    headers: true) do |person_row|
          person = person_row.to_hash
          next if Person.exists? person
          Person.create!(person)
        end
      end
    end

    desc 'Fill the cities table with example data'
    task cities: :environment do
      City.transaction do
        CSV.foreach(Rails.root + 'data/cities.csv',
                    headers: true) do |city_row|
          city = city_row.to_hash
          next if City.exists? city
          City.create!(city)
        end
      end
    end

    # desc 'Fill the pets table with example data'
    # task companies: :environment do
    #   Company.transaction do
    #     CSV.foreach(Rails.root + 'data/companies.csv',
    #                 headers: true) do |company_row|
    #       company = company_row.to_hash
    #       next if Company.exists? company
    #       Company.create!(company)
    #     end
    #   end
    # end

    # desc 'Fill the pets table with example data'
    # task skills: :environment do
    #   Skill.transaction do
    #     CSV.foreach(Rails.root + 'data/skills.csv',
    #                 headers: true) do |skill_row|
    #       skill = skill_row.to_hash
    #       next if Skill.exists? skill
    #       Skill.create!(skill)
    #     end
    #   end
    # end
  end
end
