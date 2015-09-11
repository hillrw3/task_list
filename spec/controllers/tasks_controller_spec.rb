require 'rails_helper'

describe TasksController do

  before do
    sign_in create_user
  end

  describe '#save' do
    it 'saves the task' do
      xhr :post, :create, task: {description: 'new task'}, format: :json

      expect(Task.last.description).to eq 'new task'
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

  describe '#restart' do
    it 'changes the status from finished to started' do
      task = create_task(status: 'finished')
      expect(task.status).to eq 'finished'
      xhr :patch, :restart, id: task.id
      task.reload

      expect(task.status).to eq 'started'
    end
  end
end