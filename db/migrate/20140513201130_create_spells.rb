class CreateSpells < ActiveRecord::Migration
  def change
    create_table :spells do |t|
      t.string :name

      t.timestamps
    end
  end
end
