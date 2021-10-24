class CreateNeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :needs do |t|
      t.string :name
      t.integer :amount
      t.string :priority
      t.string :status
      t.references :budget, foreign_key: true

      t.timestamps
    end
  end
end
