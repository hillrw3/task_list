require 'rails_helper'

describe 'User Authentication', js: true do

  context 'User Registration' do
    it 'allows a new user register' do
      visit '/'

      click_on 'Sign up'

      expect(page).to have_content 'Sign up'

      within '#registration-form' do
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Username', with: 'user1'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'Register'
      end

      expect(User.last.username).to eq 'user1'
      expect(current_path).to eq root_path
    end

    it 'allows an existing user to sign in' do
      create_user(username: 'user1')
      visit '/'

      within '#login' do
        expect(page).to have_content 'Sign in'
        fill_in 'Username', with: 'user1'
        fill_in 'user[password]', with: 'password1'
        click_on 'Sign in'
      end

      sleep 0.5

      expect(current_path).to eq root_path
    end

    it 'displays an error if a user enters incorrect credentials' do
      create_user(username: 'user1')
      visit '/'

      within '#login' do
        expect(page).to have_content 'Sign in'
        fill_in 'Username', with: 'user1'
        fill_in 'user[password]', with: 'WRONGpassword'
        click_on 'Sign in'

        expect(page).to have_content 'Invalid username or password.'
      end

      expect(current_path).to eq new_user_session_path
    end
  end
end