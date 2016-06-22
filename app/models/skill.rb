class Skill < ActiveRecord::Base
  has_many :people, through: :endorsements
  has_many :endorsements
end
