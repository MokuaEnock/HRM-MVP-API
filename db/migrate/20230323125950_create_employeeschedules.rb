class CreateEmployeeschedules < ActiveRecord::Migration[7.0]
  def change
    create_table :employeeschedules do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
