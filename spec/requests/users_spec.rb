require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "POST /api/v1/login" do
    let(:password) { FFaker::Internet.password(8) }
    let(:user) { create(:user, password: password) }
    it "should login user" do
      post "/api/v1/login", params: {email: user[:email], password: password}
      expect(response).to have_http_status(:ok)
    end

    it "should not login user" do
      post "/api/v1/login", params: {email: user[:email], password: "#{user[:password]}1"}
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
