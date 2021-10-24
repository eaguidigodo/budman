json.extract! expense, :id, :day, :need, :amount, :date, :description, :budget_id, :created_at, :updated_at
json.url expense_url(expense, format: :json)
