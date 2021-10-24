class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.string :day
      t.string :need
      t.integer :amount
      t.date :date
      t.text :description
      t.references :budget, foreign_key: true

      t.timestamps
    end
  end
end
