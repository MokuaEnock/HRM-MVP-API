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
      t.integer :payslip_period
      t.integer :gross_salary
      t.integer :net_salary
      t.decimal :sacco, precision: 10, scale: 2, null: false
      t.decimal :insurance, precision: 10, scale: 2, null: false
      t.integer :discipline_score
      t.integer :attendance_score
      t.integer :punctuality_score
      t.integer :rating
      t.string :performance
      t.integer :days_present
      t.integer :days_absent
      t.integer :days_total

      t.timestamps
    end
  end
end
