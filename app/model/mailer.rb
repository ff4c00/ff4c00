# Settingslogic来自gem 'settingslogic',用来调用写在YAML里面的配置信息
class Mailer < Settingslogic
  source "#{Rails.root}/config/mailer.yml"
	namespace Rails.env
end
