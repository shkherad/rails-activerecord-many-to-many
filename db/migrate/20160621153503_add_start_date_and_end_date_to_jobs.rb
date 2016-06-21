class AddStartDateAndEndDateToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :start_date, :string
    add_column :jobs, :end_date, :string
    add_column :jobs, :salary, :integer
  end
end
