class UsersController < ApplicationController
  before_action :authenticate_user!, :load_user, except: %i(new create)
  before_action :load_user, except: %i(new create)

  def new
    @user = User.new
  end

  def show
    @q_booking = @user.bookings.joins(room: :room_type).ransack(params[:q])
    @q_payment = @user.payments.ransack(params[:q])
    @bookings = @q_booking.result
    @payments = @q_payment.result
    sort_booking_and_payment
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".success"
      redirect_to new_user_session_path
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

  def sort_booking_and_payment
    return unless params[:q] && params[:q][:s]

    @payments = @payments.order(params[:q][:s])
    @bookings = @bookings.order(params[:q][:s])
  end
end
