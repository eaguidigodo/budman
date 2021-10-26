class AddNameToBudgets < ActiveRecord::Migration[5.2]
  def change
    add_column :budgets, :name, :string
  end
end
