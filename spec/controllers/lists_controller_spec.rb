require 'rails_helper'

describe ListsController do
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
    it 'sends an email to a single recipient' do
      user = create_user
      sign_in user

      expect { xhr :post, :email, recipients: ['b@a.com'], format: :json }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'sends an email to multiple recipients' do
      user = create_user
      sign_in user

      expect { xhr :post, :email, recipients: ['b@a.com', 'jimmy@johns.com'], format: :json }.to change { ActionMailer::Base.deliveries.count }.by(1)
      email = ActionMailer::Base.deliveries.last
      expect(email.to).to eq ['b@a.com', 'jimmy@johns.com']
    end
  end
end