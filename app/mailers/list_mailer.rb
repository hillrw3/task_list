class ListMailer < ActionMailer::Base
  default from: 'task@list.com'

  def list(recipient, list)
    @list = list
    mail(to: recipient, subject: @list.name)
  end
end