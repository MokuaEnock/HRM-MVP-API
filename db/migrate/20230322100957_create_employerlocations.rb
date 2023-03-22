class CreateEmployerlocations < ActiveRecord::Migration[7.0]
  def change
    create_table :employerlocations do |t|

      t.timestamps
    end
  end
end
