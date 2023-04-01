class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :employee, null: false, foreign_key: true

      t.decimal :total_worked_hours, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal :pay, precision: 10, scale: 2, default: 0.0, null: false
      t.string :reason
      t.time :clock_in
      t.time :clock_out
      t.date :date

      t.timestamps
    end
  end
end
