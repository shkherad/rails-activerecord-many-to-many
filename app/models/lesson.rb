class Lesson < ActiveRecord::Base
  belongs_to :spell
  belongs_to :student
end
