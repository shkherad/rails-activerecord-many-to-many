# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  title      :string
#  duration   :integer
#  price      :decimal(, )
#  album_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :song do
    title "MyString"
artist "MyString"
duration 1
price "9.99"
album nil
  end

end
