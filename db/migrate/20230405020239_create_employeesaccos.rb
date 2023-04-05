class CreateEmployeesaccos < ActiveRecord::Migration[7.0]
  def change
    create_table :employeesaccos do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :name
      t.string :registration_number
      t.string :bank_name
      t.string :bank_branch
      t.string :bank_account_name
      t.string :bank_account_number
      t.string :membership_number
      t.integer :contribution_amount
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
