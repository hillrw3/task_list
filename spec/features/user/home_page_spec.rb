require 'rails_helper'

describe 'User Home Page', js: true do
  let!(:user) { create_user(username: 'bob', password: 'password') }

  before do
    sign_in_user('bob', 'password')
  end

  it 'can add a new task to a list' do
    expect(page).to have_content "bob's tasks"
    expect(page).to have_no_content 'shazam!'
    fill_in 'new-task', with: 'shazam!'
    page.find('#add-task').click

    within('#started-tasks') do
      expect(page).to have_content 'shazam!'
    end
  end

  it 'can finish a task' do
    fill_in 'new-task', with: 'shazam!'
    page.find('#add-task').click

    page.find('#remove-task').click
    sleep 0.2

    within('#started-tasks') do
      expect(page).to have_no_content 'shazam!'
    end

    page.find('#finished-toggle').click

    within('#finished-tasks') do
      expect(page).to have_content 'shazam!'
    end
  end

  it 'can restart a task' do
    create_task(description: 'learn to moonwalk', status: 'finished', list: user.lists.first)
    visit '/'

    page.find('#finished-toggle').click

    within('#finished-tasks') do
      expect(page).to have_content 'learn to moonwalk'
      page.find('#restart-task').click
      sleep 0.2
      expect(page).to have_no_content 'learn to moonwalk'
    end

    within('#started-tasks') do
      expect(page).to have_content 'learn to moonwalk'
    end
  end

  it 'has a unique task list for every user' do
    user2 = create_user

    fill_in 'new-task', with: 'shazam!'
    page.find('#add-task').click

    expect(page).to have_content 'shazam!'

    click_on 'Log out'

    sign_in_user(user2.username, user2.password)

    expect(page).to have_no_content 'shazam!'
  end

  describe 'List Management' do
    it 'lets a user add a new list' do
      click_on 'Add New List'

      within '#new-list' do
        fill_in 'Name', with: 'Groceries'
        click_on 'Create'
      end
    end

    describe 'emailing lists' do
      before do
        fill_in 'new-task', with: 'shazam!'
        page.find('#add-task').click

        page.find('#options-dropdown').click
        page.find('#email-list').click
      end

      it 'allows a user to email a task list to a single user' do
        within '#email-modal' do
          fill_in 'recipients', with: 'myfriend@gmail.com'
          click_on 'Send'
        end

        sleep 0.5

        email = ActionMailer::Base.deliveries.last

        expect(email.subject).to eq "bob's tasks"
        expect(email.to).to eq ['myfriend@gmail.com']
        expect(email.body).to have_content 'shazam!'
      end

      it 'allows a user to email a task list to a multiple users' do
        within '#email-modal' do
          fill_in 'recipients', with: 'myfriend@gmail.com, myotherfriend@yahoo.com'
          click_on 'Send'
        end

        sleep 0.5

        email = ActionMailer::Base.deliveries.last

        expect(email.subject).to eq "bob's tasks"
        expect(email.to).to eq ['myfriend@gmail.com', 'myotherfriend@yahoo.com']
        expect(email.body).to have_content 'shazam!'
      end
    end

    it 'can delete a list' do
      expect(page).to have_content "bob's tasks"

      page.find('#options-dropdown').click
      page.find('#delete-list').click

      expect(page).to have_no_content "bob's tasks"
    end
  end
end