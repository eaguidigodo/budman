require 'rails_helper'
RSpec.describe 'Budget management function', type: :system do

    def user_login
        visit new_user_session_path
        fill_in 'user[email]', with: 'user1@user.com'
        fill_in 'user[password]', with: 'userpass'
        click_button 'Sign in'
      end

    before do
        @user = FactoryBot.create(:user)
        @budget = FactoryBot.create(:budget, user_id: User.last.id)
                FactoryBot.create(:need, budget_id: Budget.last.id)
                FactoryBot.create(:need, budget_id: Budget.last.id)
                FactoryBot.create(:expense, budget_id:Budget.last.id)
        user_login
        visit budgets_path
    end

    describe 'New creation function' do
        context 'When creating a new budget' do
          it 'The created budget is displayed' do
            click_button "New budget"
            #select '2011/01/01', :from => 'Start Date'
            #select_date(2.weeks.ago, from: "start_date")
            #select '2021-02-10', from: 'budget[start_date]'
            #select '2021-02-10', from: 'budget[start_date]'
            fill_in 'budget[amount]', with: "150000"
            #fill_in 'budget[needs_attributes][name]', with: 'food'
            #fill_in 'need[amount]', with: '52000'
            #select 'Very important', from: 'need[priority]'
            click_on 'Create a budget'
            expect(page).to have_content 'Budget details'
          end
        end
      end

      describe 'List display function' do
        context 'When transitioning to the list screen' do
          it 'The created task list is displayed' do
            visit budgets_path
            expect(page).to have_content '150000'
          end
        end
      end


end