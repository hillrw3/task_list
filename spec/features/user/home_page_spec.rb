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
    create_task(description: 'learn to moonwalk', status: 'finished', list: user.list)
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
end