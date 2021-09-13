class UsersController < ApplicationController
  before_action :authenticate_user!, :load_user, except: %i(new create)
  before_action :load_user, except: %i(new create)

  def new
    @user = User.new
  end

  def show; end

  def show_bookings
    @q_booking = @user.bookings.joins(room: :room_type).ransack(params[:q])
    @all_bookings = @q_booking.result
    @all_bookings = @all_bookings.order(params[:q][:s]) if params[:q]
    @bookings = @all_bookings.page(params[:page]).per(5)
  end

  def show_payments
    @q_payment = @user.payments.ransack(params[:q])
    @all_payments = @q_payment.result
    @all_payments = @all_payments.order(params[:q][:s]) if params[:q]
    @payments = @all_payments.page(params[:page]).per(5)
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
end
