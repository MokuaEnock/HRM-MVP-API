class CreateEmployerfinancials < ActiveRecord::Migration[7.0]
  def change
    create_table :employerfinancials do |t|
      t.references :employer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
