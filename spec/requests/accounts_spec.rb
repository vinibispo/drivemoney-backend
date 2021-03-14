require "rails_helper"

RSpec.describe "Accounts", type: :request do
  describe "GET /index" do
    let(:user) { create(:user) }
    let(:token) { Tokens::Create.call(user: user).data[:token] }
    it "returns unauthorized when is without token" do
      get "/api/v1/accounts"
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns ok when has right token" do
      get "/api/v1/accounts", headers: {"Authorization": "Bearer #{token}"}
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    let(:user) { create(:user) }
    let(:token) { Tokens::Create.call(user: user).data[:token] }
    let(:account) { attributes_for(:account) }
    it "returns unauthorized when is without token" do
      post "/api/v1/accounts"
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns ok when has right token" do
      post "/api/v1/accounts", params: {account: account}, headers: {"Authorization": "Bearer #{token}"}
      expect(response).to have_http_status(:created)
    end

    it "returns unprocessable_entity when has information missing" do
      post "/api/v1/accounts", params: {account: account.merge({name: nil})}, headers: {"Authorization": "Bearer #{token}"}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  describe "POST /create" do
    let(:user) { create(:user) }
    let(:token) { Tokens::Create.call(user: user).data[:token] }
    let(:account) { attributes_for(:account) }
    it "returns unauthorized when is without token" do
      post "/api/v1/accounts"
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns ok when has right token" do
      post "/api/v1/accounts", params: {account: account}, headers: {"Authorization": "Bearer #{token}"}
      expect(response).to have_http_status(:created)
    end

    it "returns unprocessable_entity when has information missing" do
      post "/api/v1/accounts", params: {account: account.merge({name: nil})}, headers: {"Authorization": "Bearer #{token}"}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT /update" do
    let(:user) { create(:user) }
    let(:token) { Tokens::Create.call(user: user).data[:token] }
    let(:account_created) { create(:account, user: user) }
    let(:account) { attributes_for(:account) }
    it "returns unauthorized when is without token" do
      put "/api/v1/accounts/#{account_created.id}"
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns ok when has right token" do
      put "/api/v1/accounts/#{account_created.id}", params: {account: account}, headers: {"Authorization": "Bearer #{token}"}
      expect(response).to have_http_status(:ok)
    end

    it "returns unprocessable_entity when has information missing" do
      put "/api/v1/accounts/#{account_created.id}", params: {account: account.merge({name: nil})}, headers: {"Authorization": "Bearer #{token}"}
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns not_found when has information missing" do
      put "/api/v1/accounts/#{FFaker::Random.rand(100..1000)}", params: {account: account.merge({name: nil})}, headers: {"Authorization": "Bearer #{token}"}
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PUT /destroy" do
    let(:user) { create(:user) }
    let(:token) { Tokens::Create.call(user: user).data[:token] }
    let(:account_created) { create(:account, user: user) }
    let(:account) { attributes_for(:account) }
    it "returns unauthorized when is without token" do
      delete "/api/v1/accounts/#{account_created.id}"
      expect(response).to have_http_status(:unauthorized)
    end
    it "returns no_content when has right token" do
      delete "/api/v1/accounts/#{account_created.id}", headers: {"Authorization": "Bearer #{token}"}
      expect(response).to have_http_status(:no_content)
    end

    it "returns not_found when has information missing" do
      delete "/api/v1/accounts/#{FFaker::Random.rand(100..1000)}", params: {account: account.merge({name: nil})}, headers: {"Authorization": "Bearer #{token}"}
      expect(response).to have_http_status(:not_found)
    end
  end
end
