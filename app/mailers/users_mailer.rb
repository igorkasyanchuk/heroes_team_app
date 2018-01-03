class UsersMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.users_mailer.credentials.subject
  #
  def credentials(user)
    @greeting = 'Hello'
    @user = user

    mail to: user.email, subject: 'Your credentials'
  end
end
