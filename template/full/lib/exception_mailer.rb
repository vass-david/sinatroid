require 'pony'

class ExceptionMailer
  def send(error)
    throw error
    config = App.settings.exception_mailer

    Pony.mail(to: config['to'],
              from: config['from'], 
              subject: "#{config['subject']} <#{error.class}>",
              body: "#{error.message}",
              via: :sendmail)
  end
end
