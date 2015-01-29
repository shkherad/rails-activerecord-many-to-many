class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.string :genre
      t.string :uuid
      t.timestamps
    end
  end
end
