class Expense < ApplicationRecord
  belongs_to :budget

  validates :day, presence: true
  validates :need, presence: true
  validates :amount, presence: true
  validates :date, presence: true
  validates :description, presence: true

  validate do |expense|
    @budget = Budget.find(expense.budget_id)
    if expense.date < @budget.start_date or expense.date > @budget.end_date
      errors.add(:date, I18n.t('models.expense.notice'))
    end
  end
end
