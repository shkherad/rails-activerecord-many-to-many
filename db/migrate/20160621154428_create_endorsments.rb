class CreateEndorsments < ActiveRecord::Migration
  def change
    create_table :endorsments do |t|
      t.references :skill, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
