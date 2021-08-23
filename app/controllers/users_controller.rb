class UsersController < ApplicationController
  before_action :logged_in_user, :load_user, except: %i(new create)
  before_action :load_user, except: %i(new create)

  def new
    @user = User.new
  end

  def show
    @bookings = @user.bookings.joins :room
    @payments = @user.payments
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash[:danger] = t ".fail"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit User::PERMITTED
  end
end
