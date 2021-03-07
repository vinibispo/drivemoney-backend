require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "POST /api/v1/users" do
    let(:user) { create(:user) }
    it "should login user" do
      post "/api/v1/login", params: {email: user[:email], password: user[:password]}
    end
  end
end
