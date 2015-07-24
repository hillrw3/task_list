class TasksController < ApplicationController
  respond_to :json
  before_filter :find_task, only: [:destroy, :finish, :restart]
  attr_accessor :task

  def index
    respond_with categorized_tasks
  end

  def create
    task = Task.new(task_params)
    task.save
    render json: TaskPresenter.new(task)
  end

  def destroy
    task.destroy
    render nothing: true
  end

  def finish
    task.update_attributes(status: 'finished')
    render json: TaskPresenter.new(task)
  end

  def restart
    task.update_attributes(status: 'started')
    render json: TaskPresenter.new(task)
  end

  private

  def find_task
    @task ||= Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description)
  end

  def categorized_tasks
    categorize_by_status(presented_tasks)
  end

  def categorize_by_status(presented_tasks)
    categorized_tasks = {}
    presented_tasks.each do |task|
      status_key = task.status
      categorized_tasks.has_key?(status_key) ? categorized_tasks[status_key] << task : categorized_tasks[status_key] = [task]
    end
    categorized_tasks
  end

  def presented_tasks
    @_presented_tasks ||= Task.all.each { |task|  TaskPresenter.new(task) }
  end
end