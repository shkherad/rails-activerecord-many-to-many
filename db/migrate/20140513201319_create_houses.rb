class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :name
      t.references :school, index: true

      t.timestamps
    end
  end
end
