class Admin::UsersController < AdminController
  before_action :load_user, except: %i(index new create)
  before_action :is_staff?, only: %i(new create destroy)

  def new
    @user = User.new
  end

  def index
    @users = User.where(role: params[:role]).page(params[:page])
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.update activated: true, activated_at: Time.zone.now
      flash[:success] = t "users.new.success"
      redirect_to admin_path
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to admin_path
  end

  private
  def user_params
    params.require(:user).permit User::PERMITTED2
  end

  def is_staff?
    return unless current_user.staff?

    redirect_to admin_path
  end
end
