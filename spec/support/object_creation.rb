module ObjectCreation

  def create_task(options={})
    attributes = {description: "Task #{rand(1000)}", status: 'started'}.merge(options)
    Task.create(attributes)
  end

  def create_user(options={})
    attributes = {username: "user_#{rand(1000)}", email: 'user@example.com', password: 'password1'}.merge(options)
    User.create(attributes)
  end

  def sign_in(username, password)
    visit '/'

    within '#login' do
      fill_in 'Username', with: username
      fill_in 'user[password]', with: password
      click_on 'Sign in'
    end
  end
end