require 'rails_helper'

describe LandingController do
  describe 'GET #show' do
    it 'renders the show template' do
      get :show

      expect(response).to render_template('show')
    end
  end
end