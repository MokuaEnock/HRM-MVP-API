class CreateEmployerdetails < ActiveRecord::Migration[7.0]
  def change
    create_table :employerdetails do |t|
      t.references :employer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
