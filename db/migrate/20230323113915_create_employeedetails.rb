class CreateEmployeedetails < ActiveRecord::Migration[7.0]
  def change
    create_table :employeedetails do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :first_name
      t.string :second_name
      t.string :third_name
      t.integer :national_id
      t.string :job_role
      t.string :gender
      t.string :job_group
      t.integer :phone

      t.timestamps
    end
  end
end
