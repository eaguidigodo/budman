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
        @user2 = FactoryBot.create(:second_user)
        user_login
        @budget = FactoryBot.create(:budget, user_id: User.last.id)
                FactoryBot.create(:need, budget_id: Budget.last.id)
                FactoryBot.create(:need, budget_id: Budget.last.id)
                FactoryBot.create(:expense, budget_id:Budget.last.id)
                visit budgets_path


    end

    describe 'New creation function' do
        context 'When creating a new budget' do
          it 'The created budget is displayed' do
            click_button "Nouveau budget"
            fill_in 'budget[start_date]', with: "10/12/2022"
            fill_in 'budget[end_date]', with: "11/12/2022"
            fill_in 'budget[amount]', with: "150000"
            #fill_in 'budget.needs[name]', with: "food"
            #within("form.needs") do
             # fill_in :name, with: "food"
            #end
            click_on 'Créer budget'
            expect(page).to have_content 'Votre Budget a été créé avec succès.'
          end
        end
      end

      describe 'Detail display function' do
        context 'When transitioning to the budget detail list screen' do
          it 'The created budget detail is displayed' do
            visit budget_path(Budget.last.id)
            expect(page).to have_content '150000'
            expect(page).to have_content '2022-10-01'
          end
        end
      end

      describe 'Expense creation function' do
        context 'When creating a new expense' do
          it 'The created budget detail is displayed' do
            visit new_expense_path
            fill_in 'expsense[day]', with: "Lundi"
            select " ", from: 'expense[need]'
            fill_in 'expense[date]', with: "10/13/2022"
            fill_in 'expsense[amount]', with: "2300"
            fill_in 'expsense[description]', with: "Pizza"
            get :show, params: { budget_id: Budget.last.id}
            #fill_in 'params[:format]', with: Budget.last.id
            click_on "Enregistrer une dépense"
            expect(page).to have_content 'Détails de la dépense '
          end
        end
      end

      describe 'List display function' do
        context 'When transitioning to the list screen' do
          it 'The created task list is displayed' do
            visit budgets_path
            expect(page).to have_content '150000'
            expect(page).to have_content '2022-10-01'
          end
        end
      end


end