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
    fill_in 'new_task', with: 'shazam!'
    page.find('#add_task').click

    within  ('#task_list') do
      expect(page).to have_content 'shazam!'
    end
  end
end