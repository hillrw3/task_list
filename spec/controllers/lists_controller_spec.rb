require 'rails_helper'

describe ListsController do
  let!(:user) { create_user }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it "returns an array of the current user's task lists" do
      user = create_user
      sign_in user

      xhr :get, :index, format: :json
      json_response = JSON.parse(response.body)

      expect(json_response).to be_a Array
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