json.extract! budget, :id, :start_date, :end_date, :amount, :created_at, :updated_at
json.url budget_url(budget, format: :json)
