class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :employee, null: false, foreign_key: true

      t.decimal :total_worked_hours, precision: 10, scale: 2
      t.decimal :pay, precision: 10, scale: 2
      t.string :reason
      t.string :time_in
      t.string :time_out
      t.string :date

      t.timestamps
    end
  end
end
