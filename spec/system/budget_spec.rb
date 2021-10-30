require 'rails_helper'
RSpec.describe 'Budget management function', type: :system do

    def user_login
        visit new_user_session_path
        fill_in 'user[email]', with: 'user1@user.com'
        fill_in 'user[password]', with: 'userpass'
        click_button 'Se connecter'
      end

    before do
        @user2 = FactoryBot.create(:second_user)
                 FactoryBot.create(:budget2, user_id: User.last.id)
        @user = FactoryBot.create(:user)
        user_login
        @budget = FactoryBot.create(:budget, user_id: User.last.id)
                FactoryBot.create(:need, budget_id: Budget.last.id)
                #FactoryBot.create(:need, budget_id: Budget.last.id)
                FactoryBot.create(:expense, budget_id: Budget.last.id)
        visit budgets_path
    end

    describe 'New budget creation function' do
        context 'When creating a new budget' do
          it 'The created budget is displayed' do
            click_button "Nouveau budget"
            fill_in 'budget[start_date]', with: "10/23/2022"
            fill_in 'budget[end_date]', with: "11/23/2022"
            fill_in 'budget[amount]', with: "150000"
            #fill_in 'budget[needs_attributes][name]', with: 'food'
            #fill_in 'need[amount]', with: '52000'
            #select 'Very important', from: 'need[priority]'
            click_on 'Créer budget'
            expect(page).to have_content 'Votre Budget a été créé avec succès.'
          end
        end
      end

      describe 'List display function' do
        context 'When transitioning to the list screen' do
          it 'The created budgets list is displayed' do
            visit budgets_path
            expect(page).to have_content '150000'
          end
        end
      end

      describe 'Create expense function' do
        context 'When creating a new expense' do
          it 'The created expense detail is displayed' do
            visit new_expense_path(Budget.last.id)
            select "Samedi", from: 'expense[day]'
            fill_in 'expense[date]', with: "10/25/2023"
            fill_in 'expense[amount]', with: "10500"
            select "food", from: 'expense[need]'
            fill_in 'expense[description]', with: "J'ai mangé une pizza"
            click_on "Enregistrer une dépense"
            expect(page).to have_content 'Dépense créée avec succès.'
          end
        end
      end

      describe 'Budget editing function' do
        context 'When editing a budget' do
          it 'The new budget details is displayed' do
            visit edit_budget_path(Budget.last.id)
            fill_in 'budget[start_date]', with: "11/23/2022"
            fill_in 'budget[end_date]', with: "12/23/2022"
            fill_in 'budget[amount]', with: "150000"
            #fill_in 'budget[needs_attributes][name]', with: 'food'
            #fill_in 'need[amount]', with: '52000'
            #select 'Very important', from: 'need[priority]'
            click_on 'Mettre à jour'
            expect(page).to have_content 'Budget a été mis à jour avec succès.'
          end
        end
      end

      describe 'Delete a need function' do
        context 'When deleting a need' do
          it 'The deleted need disapears' do
            visit needs_path
            #delete :destroy, params: {need_route: need_path()}
            click_on "Destroy"
            page.driver.browser.switch_to.alert.accept
            expect(page).not_to have_content 'On going'
          end
        end
      end

      describe 'Create a need function' do
        context 'When creating a need' do
          it 'The  need details are displayed' do
            visit new_need_path
            fill_in 'need[name]', with: "travel"
            fill_in 'need[amount]', with: "10500"
            fill_in 'need[status]', with: "Ras"
            fill_in 'need[budget_id]', with: Budget.last.id
            click_on "Create Need"
            expect(page).to have_content 'Need was successfully created.'
          end
        end
      end

      describe 'Edit an expense function' do
        context 'When editing an expense' do
          it 'The new expense details are displayed' do
            visit edit_expense_path(Expense.last.id)
            select "Dimanche", from: 'expense[day]'
            fill_in 'expense[date]', with: "11/23/2022"
            fill_in 'expense[amount]', with: "10500"
            select "food", from: 'expense[need]'
            fill_in 'expense[description]', with: "J'ai mangé une pizza"
            click_on "Mettre à jour cette dépense"
            expect(page).to have_content 'Expense was successfully updated.'
          end
        end
      end

      describe 'Edit a need function' do
        context 'When Edtiting a need' do
          it 'The new need details are displayed' do
            visit edit_need_path(Need.last.id)
            fill_in 'need[name]', with: "Visa"
            fill_in 'need[amount]', with: "10500"
            fill_in 'need[status]', with: "On going"
            fill_in 'need[budget_id]', with: Budget.last.id
            click_on "Update Need"
            expect(page).to have_content 'On going'
          end
        end
      end


      describe 'Delete an Expense function' do
        context 'When deleting an expense' do
          it 'The deleted expense disapears' do
            visit budget_path(Budget.last.id)
            click_on "Supprimer"
            page.driver.browser.switch_to.alert.accept
            expect(page).not_to have_content 'pizza'
          end
        end
      end


      describe 'Delete a budget function' do
        context 'When deleting a budget' do
          it 'The deleted budget disapears' do
            visit budgets_path
            click_on "Supprimer"
            page.driver.browser.switch_to.alert.accept
            expect(page).not_to have_content '150000'
          end
        end
      end


      describe 'User cannot see other users actions' do
        context 'When login' do
          it 'The user can only see his budgets' do
            visit budgets_path
            expect(page).not_to have_content '5327889'
          end
        end
      end

end