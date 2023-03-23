class CreateEmployeelocations < ActiveRecord::Migration[7.0]
  def change
    create_table :employeelocations do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :latitide
      t.string :longitude
      t.datetime :timestamp
      
      t.timestamps
    end
  end
end
