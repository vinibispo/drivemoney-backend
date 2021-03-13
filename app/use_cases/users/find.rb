module Users
  class Find < Micro::Case
    attribute :id
    def call!
      user = User.find_by(id: id)
      return Success result: {user: user} if user.present?
      Failure(:user_not_found)
    end
  end
end
