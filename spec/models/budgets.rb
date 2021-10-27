require 'rails_helper'

RSpec.describe 'Budget model function', type: :model do


  describe 'Validation test for budget model' do
    context 'If the Budget Amount is empty' do
      it "Budget must not be registered" do
        budget = Budget.new(start_date: '2021-11-01', amount: '', end_date: '2021-11-01')
        expect(budget).not_to be_valid
      end
    end

    context 'If need field is empty when creating an expense' do
      it 'Validation is caught' do
        expense = Expense.new(day: 'Monday', date:'2021-11-01', need: '', amount:"234566", description:"no to be valid")
        expect(expense).not_to be_valid
      end
    end

  end

end