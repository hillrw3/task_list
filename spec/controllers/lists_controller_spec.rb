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
end