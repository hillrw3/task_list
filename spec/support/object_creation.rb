module ObjectCreation

  def create_task(options={})
    attributes = {description: "Task #{rand(1000)}", status: 'started'}.merge(options)
    Task.create(attributes)
  end

end