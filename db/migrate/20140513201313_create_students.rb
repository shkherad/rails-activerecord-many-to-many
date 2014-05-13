class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.references :house, index: true

      t.timestamps
    end
  end
end
