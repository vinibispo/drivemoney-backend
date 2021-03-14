require "rails_helper"

RSpec.describe "Transactions", type: :request do
  describe "GET /index" do
    let(:account) { create(:account) }
    let(:token) { Tokens::Create.call(user: account.user).data[:token] }
    it "returns unauthorized when is without token" do
      get "/api/v1/accounts/#{account.id}/transactions"
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns ok when has token" do
      get "/api/v1/accounts/#{account.id}/transactions", headers: {"Authorization" => "Bearer #{token}"}
      expect(response).to have_http_status(:ok)
    end

    it "returns not_found when has no account associated" do
      get "/api/v1/accounts/#{FFaker::Random.rand(100..1000)}/transactions", headers: {"Authorization" => "Bearer #{token}"}
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /create" do
    let(:account) { create(:account) }
    let(:token) { Tokens::Create.call(user: account.user).data[:token] }
    let(:transaction_params) { attributes_for(:transaction) }
    it "returns unauthorized when is without token" do
      post "/api/v1/accounts/#{account.id}/transactions"
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns ok when has token and has correct params" do
      post "/api/v1/accounts/#{account.id}/transactions", headers: {"Authorization" => "Bearer #{token}"}, params: {transaction: transaction_params}
      expect(response).to have_http_status(:created)
    end

    it "returns unprocessable_entity when has token, but not correct_params" do
      post "/api/v1/accounts/#{account.id}/transactions", headers: {"Authorization" => "Bearer #{token}"}, params: {transaction: transaction_params.merge({value: nil})}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  describe "PUT /update" do
    let(:account) { create(:account) }
    let(:token) { Tokens::Create.call(user: account.user).data[:token] }
    let(:transaction) { create(:transaction, account: account) }
    let(:transaction_params) { attributes_for(:transaction) }
    it "returns unauthorized when is without token" do
      put "/api/v1/accounts/#{account.id}/transactions/#{transaction.id}"
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns ok when has token and has correct params" do
      put "/api/v1/accounts/#{account.id}/transactions/#{transaction.id}", headers: {"Authorization" => "Bearer #{token}"}, params: {transaction: transaction_params}
      expect(response).to have_http_status(:ok)
    end

    it "returns unprocessable_entity when has token, but not correct_params" do
      put "/api/v1/accounts/#{account.id}/transactions/#{transaction.id}", headers: {"Authorization" => "Bearer #{token}"}, params: {transaction: transaction_params.merge({value: nil})}
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns not_found when has token, correct params, but has not valid id" do
      put "/api/v1/accounts/#{account.id}/transactions/#{FFaker::Random.rand(100..1000)}", headers: {"Authorization" => "Bearer #{token}"}, params: {transaction: transaction_params}
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /destroy" do
    let(:account) { create(:account) }
    let(:token) { Tokens::Create.call(user: account.user).data[:token] }
    let(:transaction) { create(:transaction, account: account) }
    it "returns unauthorized when is without token" do
      delete "/api/v1/accounts/#{account.id}/transactions/#{transaction.id}"
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns no_content when has token and has correct params" do
      delete "/api/v1/accounts/#{account.id}/transactions/#{transaction.id}", headers: {"Authorization" => "Bearer #{token}"}
      expect(response).to have_http_status(:no_content)
    end
  end
end
