class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  config.load_defaults 5.1
  # config.i18n.default_locale = :ja
  config.time_zone = 'Tokyo'
  config.generators do |g|
    g.assets false
    g.helper false
    g.jbuilder false
  end
  
  def require_login!
    if current_user == nil
      #binding.pry
      redirect_to new_user_path
    end
  end

  def not_user_new
    if logged_in?
      redirect_to tasks
    end
  end
end
