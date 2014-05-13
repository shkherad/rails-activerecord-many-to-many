class Knowledge < ActiveRecord::Base
  belongs_to :student
  belongs_to :spell
end
