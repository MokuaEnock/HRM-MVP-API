class CreateEmployeeworks < ActiveRecord::Migration[7.0]
  def change
    create_table :employeeworks do |t|
      t.references :employee, null: false, foreign_key: true
      t.integer :basic_salary
      t.string :employee_role
      # t.string :salary_period
      t.string :employee_number
      t.string :employee_job_group

      t.timestamps
    end
  end
end
