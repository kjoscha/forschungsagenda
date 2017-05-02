class MessageMailer < ActionMailer::Base
  default from: 'basta@lupus.uberspace.de'
  layout 'mailer'

  def confirmation_mail(participant)
    @participant = participant
    mail(to: participant.email, subject: 'Anmeldung erfolgreich')
  end
end
