# == Schema Information
#
# Table name: artists
#
#  id           :integer          not null, primary key
#  name         :string
#  union_member :boolean          default("true")
#  dob          :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :artist do
    name "MyString"
union_member false
dob "2015-02-01"
  end

end
