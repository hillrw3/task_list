class ListsController < ApplicationController
  respond_to :json

  def index
    respond_with presented_lists
  end

  def email
    recipients = params['recipients']
    list = current_user.list
    ListMailer.list(recipients, list).deliver
    render json: 200
  end

  private

  def presented_lists
    lists = current_user.lists.map { |list| ListPresenter.new(list) }
    lists
  end
end