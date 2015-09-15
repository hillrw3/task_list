require 'rails_helper'

describe ListsController do
  let!(:user) { create_user }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it "returns an array of the current user's task lists" do
      xhr :get, :index, format: :json
      json_response = JSON.parse(response.body)

      expect(json_response).to be_a Array
    end
  end

  describe 'POST #create' do
    it 'creates a new list' do
      expect { xhr :post, :create, list: {name: 'new list'}, format: :json }.to change { List.count }.by(1)
    end

    it 'sets the current users id as the user_id' do
      xhr :post, :create, list: {name: 'new list'}, format: :json

      expect(List.last.user_id).to eq user.id
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the list' do
      list = create_list(name: 'save me!!!')
      expect { xhr :delete, :destroy, id: list.id, format: :json }.to change { List.count }.by(-1)
      expect(List.find_by_name('save me!!!')).to be_nil
    end
  end

  describe 'POST #email' do
    let(:list) { create_list(user: user) }

    it 'sends an email to a single recipient' do
      expect { xhr :post, :email, recipients: ['b@a.com'], id: list.id, format: :json }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'sends an email to multiple recipients' do
      expect { xhr :post, :email, recipients: ['b@a.com', 'jimmy@johns.com'], id: list.id, format: :json }.to change { ActionMailer::Base.deliveries.count }.by(1)
      email = ActionMailer::Base.deliveries.last
      expect(email.to).to eq ['b@a.com', 'jimmy@johns.com']
    end
  end
end