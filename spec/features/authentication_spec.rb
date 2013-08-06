require 'spec_helper'
feature 'Authentication' do
  let!(:user) {FactoryGirl.create(:user)}
  describe 'Sign-up' do
    scenario 'Sign up for an account with valid information' do
      visit sign_up_path
      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "supersecure1"
      expect {click_button "Sign Up"}.to change {User.count}.by(1)
      expect(current_path).to eq(sign_in_path)
    end

    scenario 'Sign up for an account with invalid informatie' do
      visit sign_up_path
      fill_in "Email", with: "Invalid@email"
      click_button "Sign Up"
      expect(current_path).to eq(sign_up_path)
      expect(page).to have_selector('.error')
    end
  end

  describe 'Login' do
    scenario 'Login with valid information' do
      create_user
      visit sign_in_path
      fill_in "email", with: "info@example.com"
      fill_in "password", with: "secret"
      click_button "Sign In"
      expect(page).to have_content('Signed in')
    end

    scenario 'Login with false information' do
      visit sign_in_path
      fill_in "email", with: "Invalid information"
      fill_in "password", with: "Super invalid secret"
      click_button "Sign In"
      expect(page).to have_content('Email or password was invalid')
    end
  end

  describe 'Logout' do
    scenario 'When i click on Logout, i should be logged out' do
      login_user_post(user.email, 'secret')
      visit '/'
      click_link 'logout'
      expect(page).to have_content('Succesfully logged out')
    end
  end

  def create_user
    user
  end
 end
