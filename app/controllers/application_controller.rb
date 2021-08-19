class ApplicationController < ActionController::Base
  include SessionsHelper

  layout :get_layout
  before_action :set_locale

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    check = I18n.available_locales.include?(locale)
    I18n.locale = check ? locale : I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  protected
  def get_layout
    return "layouts/user_layouts/application" unless current_user&.admin?

    "layouts/admin_layouts/application"
  end
end
