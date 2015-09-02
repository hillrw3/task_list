class ListPresenter < Struct.new(:list)
  def as_json(*_)
    {
      id: list.id,
      name: list.name,
      started_tasks: list.started_tasks,
      finished_tasks: list.finished_tasks
    }
  end
end