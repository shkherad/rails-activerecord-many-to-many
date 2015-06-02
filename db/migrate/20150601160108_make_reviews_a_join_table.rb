class MakeReviewsAJoinTable < ActiveRecord::Migration
  # this method gets invoked when we run/add migrations
  def up
    remove_column :reviews, :name
    add_column :reviews, :user_id, :integer
  end

  # this method gets invoked when we rollback migration
  def down
    add_column :reviews, :name, :string
    remove_column :reviews, :user_id
  end
end
