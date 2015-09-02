require 'rails_helper'

describe ListPresenter do
  let!(:list) { List.create(id: 1, name: "someone's list")}
  let!(:task) { Task.create(id: 1, description: 'new task', list: list)}

  describe '#as_json' do
    it 'returns the list and associated tasks as json' do
      presenter = ListPresenter.new(list)

      expect(presenter.as_json).to eq({
                                        id: 1,
                                        name: "someone's list",
                                        started_tasks: [task],
                                        finished_tasks: []
                                      })
    end
  end
end