require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "POST /api/v1/login" do
    let(:password) { FFaker::Internet.password(8) }
    let(:user) { create(:user, password: password) }
    it "should login user" do
      post "/api/v1/login", params: {email: user[:email], password: password}
      expect(response).to have_http_status(:ok)
    end

    it "should not login user when has password invalid" do
      post "/api/v1/login", params: {email: user[:email], password: "#{password}1"}
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not login user when has no valid parameters" do
      post "/api/v1/login", params: {batata: "batata"}
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "POST /api/v1/users" do
    let(:user) { attributes_for(:user) }
    it "should create a new user" do
      post "/api/v1/users", params: {user: user.merge({password_confirmation: user[:password]})}
      expect(response).to have_http_status(:created)
    end

    it "should not create a user when has missing a parameter" do
      post "/api/v1/users", params: {user: user}
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "does not create a user when password does not match password_confirmation" do
      post "/api/v1/users", params: {user: user.merge({password_confirmation: FFaker::Internet.password(8)})}
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "does not create a user when password has no email" do
      post "/api/v1/users", params: {user: user.merge({email: nil})}
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should not create a user when has invalid parameters" do
      post "/api/v1/users", params: {batata: "batata"}
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "GET /api/v1/auto_login" do
    let(:password) { FFaker::Internet.password(8) }
    let(:user) { create(:user, password: password) }

    it "should auto_login" do
      post "/api/v1/login", params: {email: user[:email], password: password}
      body = JSON.parse(response.body)
      token = body["token"]
      get "/api/v1/auto_login", headers: {"Authorization" => "Bearer #{token}"}
      expect(response).to have_http_status(:success)
    end

    it "should not auto_login when has no headers" do
      get "/api/v1/auto_login"
      expect(response).to have_http_status(:unauthorized)
    end
    it "should not auto_login when has headers, but has no header Authorization" do
      get "/api/v1/auto_login", headers: {"Batata": "batata"}
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not auto_login when has headers Authorization, but has no Bearer in header" do
      get "/api/v1/auto_login", headers: {"Authorization": "batata"}
      expect(response).to have_http_status(:unauthorized)
    end
    it "should not auto_login when has invalid token" do
      get "/api/v1/auto_login", headers: {"Authorization": "Bearer 122222"}
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST /api/v1/forgot_password" do
    let(:user) { create(:user) }
    it "recieves status OK when sends email" do
      post "/api/v1/forgot_password", params: {user: {email: user[:email]}}
      expect(response).to have_http_status(:ok)
    end

    it "recieves status Not Found when not sends email valid" do
      post "/api/v1/forgot_password", params: {user: {email: "#{user[:email]}.com"}}
      expect(response).to have_http_status(:not_found)
    end

    it "recieves status Bad Request when not sends params correctly" do
      post "/api/v1/forgot_password", params: {email: user[:email]}
      expect(response).to have_http_status(:bad_request)
    end
  end
end
