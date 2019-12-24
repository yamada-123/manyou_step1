class ApplicationController < ActionController::Base
  config.load_defaults 5.1
  # config.i18n.default_locale = :ja
  config.time_zone = 'Tokyo'
  config.generators do |g|
    g.assets false
    g.helper false
    g.jbuilder false
  end
end
