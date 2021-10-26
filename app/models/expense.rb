class Expense < ApplicationRecord
  belongs_to :budget

  validates :day, presence: true
  validates :need, presence: true
  validates :amount, presence: true
  validates :date, presence: true
  validates :description, presence: true
end
