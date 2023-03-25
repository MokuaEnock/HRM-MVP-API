class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      # t.references :employer, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.string :employee_number
      t.string :password_digest

      t.timestamps
    end
  end
end
