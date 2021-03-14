require "rails_helper"

RSpec.describe Transaction, type: :model do
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:value) }
end
