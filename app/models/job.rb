class Job < ActiveRecord::Base
  belongs_to :person, inverse_of: :jobs
  belongs_to :company, inverse_of: :jobs
end
