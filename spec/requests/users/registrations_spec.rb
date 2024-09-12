require 'rails_helper'

RSpec.describe 'Users::Registrations', type: :request do
  describe 'POST /signup' do
    let(:valid_attributes) { { user: { name: 'Test User', email: 'test@example.com', password: 'password' } } }

    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post '/signup', params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it 'returns a success response' do
        post '/signup', params: valid_attributes
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect {
          post '/signup', params: { user: { email: 'invalid_email', password: 'password' } }
        }.not_to change(User, :count)
      end

      it 'returns an error response' do
        post '/signup', params: { user: { email: 'invalid_email', password: 'password' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
