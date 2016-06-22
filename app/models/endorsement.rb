class Endorsement < ActiveRecord::Base
  belongs_to :skill
  belongs_to :person
end
