class ListMailer < ActionMailer::Base
  default from: 'task@list.com'

  def list(recipients, list)
    @list = list
    mail(to: recipients, subject: @list.name)
  end
end