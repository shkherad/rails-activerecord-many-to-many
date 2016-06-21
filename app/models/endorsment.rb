class Endorsment < ActiveRecord::Base
  belongs_to :skill, inverse_of: :endorsments
  belongs_to :person, inverse_of: :endorsments
end
