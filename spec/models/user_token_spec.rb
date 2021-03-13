require "rails_helper"

RSpec.describe UserToken, type: :model do
  it { should validate_presence_of(:token) }
end
