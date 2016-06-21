class Skill < ActiveRecord::Base
  has_many :people, through: :endorsments
  has_many :endorsments
end
