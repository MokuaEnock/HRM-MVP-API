class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true

      t.datetime :date
      t.datetime :time_in
      t.datetime :time_out
      t.boolean :is_present
      t.boolean :is_late
      t.boolean :reason

      t.timestamps
    end
  end
end
