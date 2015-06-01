class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.integer :duration
      t.decimal :price
      t.references :album, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
