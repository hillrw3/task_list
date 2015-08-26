require 'rails_helper'

describe UsersController do

  describe 'GET #new' do
    it 'generates a new user object' do
      get :new

      expect(assigns(:user)).to be_a User
    end

    it 'renders the new template' do
      get :new

      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    describe 'on success' do
      it 'creates a user' do
        post :create, user: {email: 'bart@simpson.com', username: 'el bart', password: 'iamsecure', password_confirmation: 'iamsecure'}

        expect(User.last.username).to eq 'el bart'
      end
    end

    describe 'on failure' do
      it 'returns an error if the password and password_confirmation do not match' do
        post :create, user: {email: 'bart@simpson.com', username: 'el bart', password: 'iamsecure', password_confirmation: 'wrong'}

        expect(assigns(:user).errors.messages[:password_confirmation]).to_not be_nil
      end
    end

  end
end