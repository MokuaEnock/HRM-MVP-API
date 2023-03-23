class CreateEmployeedetails < ActiveRecord::Migration[7.0]
  def change
    create_table :employeedetails do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
