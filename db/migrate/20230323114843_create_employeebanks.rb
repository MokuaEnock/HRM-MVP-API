class CreateEmployeebanks < ActiveRecord::Migration[7.0]
  def change
    create_table :employeebanks do |t|
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
