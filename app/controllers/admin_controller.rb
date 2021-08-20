class AdminController < ApplicationController
  before_action :require_admin
  layout "layouts/admin_layouts/application"

  def require_admin
    return if current_user.admin?

    render file: Settings.not_found_page, status: :not_found, layout: false
  end
end
