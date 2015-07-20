require 'rails_helper'

describe TasksController do
  describe '#save' do
    it 'saves the task' do
      xhr :post, :create, task: {description: 'new task'}, format: :json

      expect(Task.last.description).to eq 'new task'
    end
  end

  describe '#index' do
    it 'retrieves all the tasks' do
      Task.create(description: 'new task')
      xhr :get, :index, format: :json
      json_response = JSON.parse(response.body)

      expect(json_response.count).to eq 1
    end
  end

  describe '#destroy' do
    it 'deletes the given task' do
      task = Task.create(description: 'new task')
      xhr :delete, :destroy, id: task.id

      expect(Task.count).to eq 0
    end
  end
end