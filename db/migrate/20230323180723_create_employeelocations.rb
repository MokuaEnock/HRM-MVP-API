class CreateEmployeelocations < ActiveRecord::Migration[7.0]
  def change
    create_table :employeelocations do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :country
      t.string :county
      t.datetime :subcounty
      t.datetime :location

      t.timestamps
    end
  end
end
