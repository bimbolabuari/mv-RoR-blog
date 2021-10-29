require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    before { get '/users' }
    it 'response status was correct' do
      expect(response).to have_http_status(:ok)
    end
    it 'correct template was rendered' do
      expect(response).to render_template('index')
    end
    it 'response body includes correct placeholder text' do
      expect(response.body).to include('This is the user profile')
    end
  end

  describe 'GET /index/id' do
    before { get '/users/1' }
    it 'response status was correct' do
      expect(response).to have_http_status(:ok)
    end
    it 'correct template was rendered' do
      expect(response).to render_template('show')
    end
    it 'response body includes correct placeholder text' do
      expect(response.body).to include('This is the user page')
    end
  end
end
