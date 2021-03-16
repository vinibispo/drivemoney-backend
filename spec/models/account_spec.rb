require "rails_helper"

RSpec.describe Account, type: :model do
  it { should validate_presence_of(:name) }
end
