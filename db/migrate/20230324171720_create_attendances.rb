class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :employee, null: false, foreign_key: true

      t.decimal :in_time, precision: 10, scale: 2
      t.decimal :out_time, precision: 10, scale: 2
      t.string :reason
      t.datetime :timein
      t.datetime :timeout

      t.timestamps
    end
  end
end
