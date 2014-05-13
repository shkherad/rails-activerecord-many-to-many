class CreateKnowledges < ActiveRecord::Migration
  def change
    create_table :knowledges do |t|
      t.references :student, index: true
      t.references :spell, index: true

      t.timestamps
    end
  end
end
