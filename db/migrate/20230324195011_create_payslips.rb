class CreatePayslips < ActiveRecord::Migration[7.0]
  def change
    create_table :payslips do |t|
      t.references :employee, null: false, foreign_key: true

      t.date :start_date, null: false
      t.date :end_date, null: false
      t.decimal :nhif, precision: 10, scale: 2, null: false
      t.decimal :nssf, precision: 10, scale: 2, null: false
      t.decimal :paye, precision: 10, scale: 2, null: false
      t.decimal :taxable_income, precision: 10, scale: 2, null: false
      t.number :payslip_period

      t.timestamps
    end
  end
end
