class Spell < ActiveRecord::Base
  has_many :knowledges
  has_many :students, through: :knowledges
end
