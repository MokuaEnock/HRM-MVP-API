class CreateEmployeefinancials < ActiveRecord::Migration[7.0]
  def change
    create_table :employeefinancials do |t|
      t.references :employee, null: false, foreign_key: true

      t.string :nssf_number
      t.string :nhif_number
      t.string :kra_pin

      t.timestamps
    end
  end
end
