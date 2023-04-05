class CreateEmployeecurrents < ActiveRecord::Migration[7.0]
  def change
    create_table :employeecurrents do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :longitude
      t.string :latitude
      t.string :timestamps

      t.timestamps
    end
  end
end
