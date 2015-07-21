require 'rails_helper'

describe TaskPresenter do
  let!(:task) { Task.create(id: 1, description: 'new task')}

  describe '#as_json' do
    it 'returns the task as json' do
      presenter = TaskPresenter.new(task)

      expect(presenter.as_json).to eq({
                                        id: 1,
                                        description: "new task",
                                        status: 'started'
                                      })
    end
  end
end