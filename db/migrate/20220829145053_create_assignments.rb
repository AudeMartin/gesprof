class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.references :school, null: false, foreign_key: true
      t.references :teacher, foreign_key: true
      t.date :date
      t.integer :progress
      t.text :teacher_message
      t.text :area_message
      t.string :token

      t.timestamps
    end
  end
end
