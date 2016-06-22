class Company < ActiveRecord::Base
  has_many :people, through: :jobs
  has_many :jobs
end
