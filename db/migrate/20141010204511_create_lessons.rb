class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :teacher
      t.belongs_to :spell, index: true
      t.belongs_to :student, index: true

      t.timestamps
    end
  end
end
