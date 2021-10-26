class CreateAddBudgetNameToExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :add_budget_name_to_expenses do |t|
      t.string :budget_name

      t.timestamps
    end
  end
end
