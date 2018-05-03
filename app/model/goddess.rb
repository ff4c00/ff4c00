class Goddess < Settingslogic
  source "#{Rails.root}/config/goddess.yml"
	namespace Rails.env
end
