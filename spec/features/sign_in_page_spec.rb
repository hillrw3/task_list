require 'rails_helper'

describe 'Sign in Page', js: true do
  before do
    visit '/'
  end

  it 'can add a new task to a list' do
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
    create_task(description: 'learn to moonwalk', status: 'finished')
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
end