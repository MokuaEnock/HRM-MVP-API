class CreateEmployeecontacts < ActiveRecord::Migration[7.0]
  def change
    create_table :employeecontacts do |t|
      t.references :employee, null: false, foreign_key: true
      t.integer :phone_number
      t.string :email_address
      t.integer :whatsapp_number

      t.timestamps
    end
  end
end
