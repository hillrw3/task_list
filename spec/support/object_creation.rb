module ObjectCreation

  def create_task(options={})
    attributes = {description: "Task #{rand(1000)}", status: 'started', list: create_list}.merge(options)
    Task.create(attributes)
  end

  def create_list(option={})
    attributes = {name: "List #{rand(100)}", user: create_user}
    List.create(attributes)
  end

  def create_user(options={})
    attributes = {username: "user#{rand(1000)}", email: "user#{rand(1000)}@example.com", password: 'password1'}.merge(options)
    User.create(attributes)
  end

  def sign_in_user(username, password)
    visit '/'

    within '#login' do
      fill_in 'Username', with: username
      fill_in 'user[password]', with: password
      click_on 'Sign in'
    end
  end
end