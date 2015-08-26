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
      let(:user_params) { {email: 'bart@simpson.com', username: 'el bart', password: 'iamsecure', password_confirmation: 'iamsecure'} }

      it 'creates a user' do
        post :create, user:user_params

        expect(User.last.username).to eq 'el bart'
      end

      it 'creates a session for the new user' do
        post :create, user:user_params

        expect(session.empty?).to be_falsey
      end
    end

    describe 'on failure' do
      it 'returns an error if the password and password_confirmation do not match' do
        post :create, user: {email: 'bart@simpson.com', username: 'el bart', password: 'iamsecure', password_confirmation: 'wrong'}

        expect(assigns(:user).errors.messages[:password_confirmation]).to_not be_nil
      end

      it 'returns errors for required fields' do
        post :create, user: {email: '', username: '', password: '', password_confirmation: ''}

        expect(assigns(:user).errors.messages[:email]).to_not be_nil
        expect(assigns(:user).errors.messages[:username]).to_not be_nil
        expect(assigns(:user).errors.messages[:password]).to_not be_nil
      end
    end

  end
end