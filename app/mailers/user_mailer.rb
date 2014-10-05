class UserMailer < ActionMailer::Base
  default from: "noreply@jake0oo0.me"

  def contact(email, user, question)
    @username = user
    @email = email
    @question = question
    mail(:to => 'jake0oo0andminecraft@gmail.com',
         :subject => "Question from #{user}",
         :reply_to => email)
  end
end