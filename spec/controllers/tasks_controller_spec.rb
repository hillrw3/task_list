require 'rails_helper'

describe TasksController do
  describe '#save' do
    it 'saves the task' do
      xhr :post, :create, task: {description: 'new task'}, format: :json

      expect(Task.last.description).to eq 'new task'
    end
  end
end