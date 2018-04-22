class ApplicationMailer < ActionMailer::Base
	default from: Mailer.mail_default_from
  layout 'mailer'
end
