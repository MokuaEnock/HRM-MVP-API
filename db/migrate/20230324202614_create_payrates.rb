class CreatePayrates < ActiveRecord::Migration[7.0]
  def change
    create_table :payrates do |t|
      t.references :employer, null: false, foreign_key: true
      
      t.string :name
      t.string :description
      t.decimal :daily_charge, precision: 10, scale: 2

      t.timestamps
    end
  end
end
