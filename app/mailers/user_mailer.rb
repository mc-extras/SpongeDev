class UserMailer < ActionMailer::Base
  default from: "noreply@jake0oo0.me"

  def contact(email, user, question)
    @username = user
    @email = email
    @question = question
    mail(:to => 'jake0oo0dev@gmail.com',
         :subject => "Question from #{user}",
         :reply_to => email)
  end

  def plugin_denied(plugin)
    @plugin = plugin
    mail(:to => plugin.user.email,
      :subject => "Your Sponge plugin has been denied.",
      :reply_to => "noreply@jake0oo0.me")
  end

  def plugin_approved(plugin)
    @plugin = plugin
    mail(:to => plugin.user.email,
      :subject => "Your Sponge plugin has been approved.",
      :reply_to => "noreply@jake0oo0.me")
  end

  def plugin_file_denied(file)
    @file = file
    mail(:to => file.plugin.user.email,
      :subject => "Your Sponge plugin download submission has been denied.",
      :reply_to => "noreply@jake0oo0.me")
  end

  def plugin_file_approved(file)
    @plugin = file
    mail(:to => file.plugin.user.email,
      :subject => "Your Sponge plugin download submission has been approved.",
      :reply_to => "noreply@jake0oo0.me")
  end
end