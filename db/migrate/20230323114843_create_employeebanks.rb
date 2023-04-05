class CreateEmployeebanks < ActiveRecord::Migration[7.0]
  def change
    create_table :employeebanks do |t|
      t.references :employee, null: false, foreign_key: true

      t.string :bank_name
      t.string :branch_name
      t.string :account_name
      t.string :bank_code
      t.string :branch_code
      t.string :preferred_currency

      t.timestamps
    end
  end
end
