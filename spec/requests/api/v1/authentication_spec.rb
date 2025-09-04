require 'rails_helper'

RSpec.describe 'Api::V1::Authentications', type: :request do
  let(:user) { create(:user) }

  describe 'POST /api/v1/auth/sign_in' do
    it 'return ok status' do
      credentials = ActionController::HttpAuthentication::Basic.encode_credentials(user.email, "123456")
      post '/api/v1/auth/sign_in', headers: { "Authorization" => credentials }
      expect(response).to have_http_status(:ok)
    end

    it 'return unauthorized with non exist email' do
      credentials = ActionController::HttpAuthentication::Basic.encode_credentials("test@email.com", "123456")
      post '/api/v1/auth/sign_in', headers: { "Authorization" => credentials }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'return unauthorized with wrong password' do
      credentials = ActionController::HttpAuthentication::Basic.encode_credentials(user.email, "654321")
      post '/api/v1/auth/sign_in', headers: { "Authorization" => credentials }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /api/v1/auth/refresh_token' do
    it 'return ok status' do
      get '/api/v1/auth/refresh_token',
          headers: { 'Authorization' => "Bearer #{login_data['access_token']}" },
          params: { refresh_token: login_data['refresh_token'] }
      expect(response).to have_http_status(:ok)
    end

    it 'return unauthorized missing refresh token' do
      get '/api/v1/auth/refresh_token',
          headers: { 'Authorization' => "Bearer #{login_data['access_token']}" }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'return unauthorized with invalid refresh token' do
      get '/api/v1/auth/refresh_token',
          headers: { 'Authorization' => "Bearer #{login_data['access_token']}" },
          params: { refresh_token: 'abc' }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  def login_data
    credentials = ActionController::HttpAuthentication::Basic.encode_credentials(user.email, "123456")
    post '/api/v1/auth/sign_in', headers: { "Authorization" => credentials }
    response.parsed_body['data']
  end
end
