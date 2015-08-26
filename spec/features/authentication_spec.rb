require 'rails_helper'

describe 'User Authentication', js: true do

  context 'User Registration' do
    it 'lets a new user register' do
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
  end
end