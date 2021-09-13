class ApplicationController < ActionController::Base
  include SessionsHelper

  layout "layouts/user_layouts/application"
  before_action :set_locale

  def after_sign_in_path_for _resource
    current_user.customer? ? root_url : rails_admin.dashboard_path
  end

  private
  rescue_from CanCan::AccessDenied do
    render file: Settings.not_found_page, status: :not_found, layout: false
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    check = I18n.available_locales.include?(locale)
    I18n.locale = check ? locale : I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_user
    @user = User.find_by slug: params[:id]
    return if @user

    flash[:danger] = t "error.not_found"
    redirect_to root_url
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
