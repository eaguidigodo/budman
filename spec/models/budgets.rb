require 'rails_helper'

RSpec.describe 'Budget model function', type: :model do


  describe 'Validation test for budget model: Amount field cannot be empty' do
    context 'If the Budget Amount is empty' do
      it "Budget must not be registered" do
        @budget = Budget.new(start_date: '2021-10-30', amount: '', end_date: '2021-11-30')
        expect(@budget).not_to be_valid
      end
    end
  end

    describe 'Validation test for budget model: We can not register a new budget with past date' do
      context 'If the start_date is less than today date' do
        it "Budget must not be registered" do
          @budget = Budget.new(start_date: '2020-10-30', amount: '', end_date: '2021-11-30')
          expect(@budget).not_to be_valid
        end
      end
    end


    describe 'Validation test for expense model: Expense date must be included in period date of budget to which its belongs to' do
      @user = FactoryBot.create(:user3)
      let!(:budget) { FactoryBot.create(:budget, start_date: '2022-10-30', amount: '5000000', end_date: '2022-11-30', user_id: User.last.id) }
      let!(:need) { FactoryBot.create(:need, name: "food", amount: "40000", priority: "important", status:"RAS", budget_id: budget.id)}

      context 'If the expense date is less than the budget start date or greater than the budget end date' do
        it "Expense must not be registered" do
          expense = Expense.new(day: "Mardi", need:"food", date:"2021-12-30", amount: "12399", description: "Eat pizza",  budget_id: budget.id) 
          expense2 = Expense.new(day: "Mercredi", need:"food", date:"2023-12-30", amount: "12399", description: "Eat pizza",  budget_id: budget.id)
          expense3 = Expense.new(day: "Vendredi", need:"food", date:"2022-10-31", amount: "12399", description: "Eat pizza",  budget_id: budget.id)
          expect(expense).not_to be_valid
          expect(expense2).not_to be_valid
          expect(expense3).to be_valid
        end
      end
  end

  describe 'Validation user model: user must provide email address' do
    context 'If the user email fiekd is empty' do
      it "User must not be registered" do
        user = User.new(name: 'test', email: '', password:"testpass")
        expect(user).not_to be_valid
      end
    end
  end

    describe 'Validation user model: password must 6 character min' do
      context 'if the user password lenght is less than 6 characters' do
        it "User must not be registered" do
          user = User.new(name: 'test', email: 'test@test.com', password:"test")
          expect(user).not_to be_valid
        end
      end
    end

end