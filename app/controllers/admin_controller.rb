class AdminController < ApplicationController
  before_action :require_manager
  layout "layouts/admin_layouts/application"

  def require_manager
    return if current_user&.admin? || current_user&.staff?

    render file: Settings.not_found_page, status: :not_found, layout: false
  end
end
