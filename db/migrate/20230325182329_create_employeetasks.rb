class CreateEmployeetasks < ActiveRecord::Migration[7.0]
  def change
    create_table :employeetasks do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
