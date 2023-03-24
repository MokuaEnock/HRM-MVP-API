class CreatePayslips < ActiveRecord::Migration[7.0]
  def change
    create_table :payslips do |t|
      t.references :employee, null: false, foreign_key: true
      
      t.date :month
      t.integer :basic_pay
      t.integer :deductions, default: 0
      t.integer :paye, default: 0
      t.integer :nhif, default: 0
      t.integer :nssf, default: 0
      t.integer :net_pay, default: 0

      t.timestamps
    end
  end
end
