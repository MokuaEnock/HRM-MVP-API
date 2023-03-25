class CreateDisciplinaries < ActiveRecord::Migration[7.0]
  def change
    create_table :disciplinaries do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :type
      t.date :date
      t.string :description
      t.string :verdict

      t.timestamps
    end
  end
end
