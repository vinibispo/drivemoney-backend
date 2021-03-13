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

  def forgot_password(id:, token:, **)
    @user = Users::Find.call(id: id).data[:user]
    mail to: @user.email
  end
end
