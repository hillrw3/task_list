class ListsController < ApplicationController
  respond_to :json

  def index
    list = current_user.list
    respond_with ListPresenter.new(list)
  end

  def email
    recipients = params['recipients']
    list = current_user.list
    ListMailer.list(recipients, list).deliver
    render json: 200
  end
end