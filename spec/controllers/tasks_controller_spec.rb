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
      create_task
      xhr :get, :index, format: :json
      json_response = JSON.parse(response.body)

      expect(json_response.count).to eq 1
    end

    it 'retrieves and categorizes the tasks' do
      create_task
      Task.create(description: 'finished task', status: 1)
      xhr :get, :index, format: :json
      json_response = JSON.parse(response.body)

      expect(json_response.has_key?('started')).to be_truthy
      expect(json_response.has_key?('finished')).to be_truthy
    end
  end

  describe '#destroy' do
    it 'deletes the given task' do
      task = create_task
      xhr :delete, :destroy, id: task.id

      expect(Task.count).to eq 0
    end
  end

  describe '#finish' do
    it 'marks the task as finished' do
      task = create_task
      xhr :patch, :finish, id: task.id
      task.reload

      expect(task.status).to eq 'finished'
    end
  end

  private

  def create_task
    Task.create(description: 'new task')
  end
end