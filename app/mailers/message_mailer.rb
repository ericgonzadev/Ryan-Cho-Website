class MessageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.send_message.subject
  #
  def send_message(message)
    @message = message
    mail to: "ryancho508@gmail.com", subject: "Message received on personal website"
  end
end
