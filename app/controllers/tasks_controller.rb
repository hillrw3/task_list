class TasksController < ApplicationController
  respond_to :json

  def index
    tasks = get_and_categorize_tasks

    respond_with tasks
  end

  def create
    task = Task.new(task_params)
    task.save
    render json: TaskPresenter.new(task)
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    render nothing: true
  end

  def finish
    task = Task.find(params[:id])
    task.update_attributes(status: 'finished')
    render json: TaskPresenter.new(task)
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end

  def get_and_categorize_tasks
    categorized_tasks = {}
    presented_tasks.each do |task|
      status_key = task.status
      categorized_tasks.has_key?(status_key) ? categorized_tasks[status_key] << task : categorized_tasks[status_key] = [task]
    end
    categorized_tasks
  end

  def presented_tasks
    Task.all.each { |task|  TaskPresenter.new(task) }
  end
end