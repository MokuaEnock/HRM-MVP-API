class CreateDisciplines < ActiveRecord::Migration[7.0]
  def change
    create_table :disciplines do |t|
      t.references :employee, null: false, foreign_key: true
      t.integer :points, default: 0

      t.string :name
      t.string :description
      t.string :reported_date
      t.string :type
      t.string :verdict
      t.string :employee_statement
      t.string :reason
      t.string :action_taken
      t.boolean :verbal_warning, default: false
      t.boolean :written_warning, default: false
      t.boolean :suspension, default: false
      t.boolean :termination, default: false
      t.string :suspension_reason
      t.datetime :suspension_start
      t.datetime :suspension_end

      t.timestamps
    end
  end
end
