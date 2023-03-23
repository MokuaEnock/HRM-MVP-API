class CreateEmployerbanks < ActiveRecord::Migration[7.0]
  def change
    create_table :employerbanks do |t|
      t.references :employer, null: false, foreign_key: true

      t.string :name
      t.timestamps
    end
  end
end
