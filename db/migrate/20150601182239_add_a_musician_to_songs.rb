class AddAMusicianToSongs < ActiveRecord::Migration
  def up
    add_column :songs, :musician_id, :integer
  end

  # if you want to rollback this migration
  def down
    remove_column :songs, :musician_id
  end
end
