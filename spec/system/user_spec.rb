require 'rails_helper'
RSpec.describe 'User registration / login / logout function', type: :system do

  def user_login
    visit new_user_session_path
    fill_in 'user[email]', with: 'user1@user.com'
    fill_in 'user[password]', with: 'userpass'
    click_button 'Sign in'
  end

  def admin_login
    visit new_user_session_path
    fill_in 'user[email]', with: 'admin@user.com'
    fill_in 'session[password]', with: 'userpass'
    click_button 'Sign in'
  end

  describe 'User registration test' do
    context 'No user data and no login' do
      it 'Test of new user registration' do
        visit new_user_registration_path 
        fill_in 'user[name]', with: 'user1'
        fill_in 'user[email]', with: 'user1@user.com'
        fill_in 'user[password]', with: 'userpass'
        fill_in 'user[password_confirmation]', with: 'userpass'
        click_on "Create account"
        expect(page).to have_content 'Welcome to budman'
      end
      it 'A test that jumps to the login screen when you are not logged in' do
        visit budgets_path
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe 'User Log in test' do
    before do
        @user = FactoryBot.create(:user)
        user_login
    end

    context 'User already has an account' do
        it 'User can log in' do
            expect(page).to have_content 'Create new budget'
        end
    end

    context 'User is actually logged in and wants to logout' do
        it 'Being able to log out' do
            click_link 'Logout'
            expect(current_path).to eq new_user_session_path
        end
    end
end


          
end