require 'rails_helper'

describe ListsController do
  describe 'GET #index' do
    it "finds the current user's task list" do
      user = create_user
      sign_in user

      xhr :get, :index, format: :json
      json_response = JSON.parse(response.body)

      expect(json_response['name']).to include user.username
    end
  end

  describe 'POST #email' do
    it 'sends an email to a single recipient' do
      user = create_user
      sign_in user

      expect { xhr :post, :email, recipients: 'b@a.com', format: :json }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'sends an email to a single recipient' do
      user = create_user
      sign_in user

      expect { xhr :post, :email, recipients: 'b@a.com', format: :json }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end