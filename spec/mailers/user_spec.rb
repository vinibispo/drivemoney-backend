require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome" do
    let(:user) { User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "123456") }
    let(:mail) { UserMailer.with(user: user).welcome }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome aboard")
      expect(mail.to).to eq(["john@example.com"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end
end
