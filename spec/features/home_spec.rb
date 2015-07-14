require 'rails_helper'

describe 'Home', js: true do
  before do
    visit '/'
  end
  it 'says "Task List"' do
    expect(page).to have_content 'Task List'
  end

  it 'can add a new task to a list' do
    expect(page).to have_no_content 'shazam!'
    fill_in 'new-task', with: 'shazam!'
    page.find('#add-task').click

    within  ('#task-list') do
      expect(page).to have_content 'shazam!'
    end
  end

  it 'can remove a task from the list' do
    expect(page).to have_no_content 'shazam!'
    fill_in 'new-task', with: 'shazam!'
    page.find('#add-task').click

    page.find('#remove-task').click
    expect(page).to have_no_content 'shazam!'
  end
end