require 'rails_helper'

describe 'Home', js: true do
  before do
    visit '/'
  end
  it 'says "Task List"' do
    expect(page).to have_content 'Task List'
  end

  it 'has a responsive input and output' do
    expect(page).to have_no_content 'shazam!'
    fill_in 'new_task', with: 'shazam!'

    within  ('#test_output') do
      expect(page).to have_content 'shazam!'
    end
  end
end