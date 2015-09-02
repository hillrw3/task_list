class TasksController < ApplicationController
  respond_to :json
  before_filter :find_task, only: [:destroy, :finish, :restart]
  attr_accessor :task

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
end