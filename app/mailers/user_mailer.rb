class UserMailer < ActionMailer::Base
  default from: "brandon.m.wieber@gmail.com"

  def new_user(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Blocipedia!")
  end
end
