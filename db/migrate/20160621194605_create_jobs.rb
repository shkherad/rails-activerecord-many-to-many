class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.date :start_date
      t.date :end_date
      t.integer :salary
      t.references :person, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
