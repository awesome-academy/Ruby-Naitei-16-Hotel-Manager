class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      login user
    else
      flash.now[:danger] = t ".login_fail"
      render :new
    end
  end

  def login user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    user.admin? ? redirect_to(admin_path) : redirect_to(root_url)
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
