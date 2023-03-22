class CreateEmployerlocations < ActiveRecord::Migration[7.0]
  def change
    create_table :employerlocations do |t|
      t.references :employer, null: false, foreign_key: true

      t.string :county

      t.timestamps
    end
  end
end
