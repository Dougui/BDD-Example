class UserMailer < ActionMailer::Base
  default :from => "guirec.corbel@gmail.com"

  def activation(user)
    @user = user
    mail(:to => user.email, :subject => t(".title", :scope => 'user_mailer.activation'))
  end

  def reset_password(user)
    @user = user
    mail(:to => user.email, :subject => t(".title", :scope => 'user_mailer.reset_password'))
  end
end
