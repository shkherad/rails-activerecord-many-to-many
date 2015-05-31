class MakeReviewsAJoinTable < ActiveRecord::Migration
  def up
    add_column :reviews, :user_id, :integer
    remove_column :reviews, :name
  end

  def down
    add_column :reviews, :name, :string
    remove_column :reviews, :name
  end
end
