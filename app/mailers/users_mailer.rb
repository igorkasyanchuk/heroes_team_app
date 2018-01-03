class UsersMailer < ApplicationMailer
  def credentials(user)
    @greeting = 'Hello'
    @user = user
    mail to: user.email, subject: 'Your credentials', content_type: 'html'
  end
end
