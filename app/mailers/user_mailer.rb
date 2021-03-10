class UserMailer < ApplicationMailer
  def welcome
    user = params[:user]

    mail(
      to: user.email,
      body: "Hi #{user.first_name}, thanks for signing up...",
      subject: "Welcome aboard",
      content_type: "text/plain;charset=UTF-8"
    )
  end
end
