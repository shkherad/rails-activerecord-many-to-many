class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :city
      t.string :region
      t.string :country

      t.timestamps null: false
    end
  end
end
