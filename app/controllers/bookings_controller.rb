class BookingsController < ApplicationController
  include BookingsHelper

  before_action :logged_in_user
  before_action :check_numberic, :booked_room_ids, only: :create
  before_action :load_booking, except: :create
  before_action :check_change_booking, only: %i(update destroy)

  def show; end

  def create
    params[:booking].except(:total, :room_type)
    if Booking.create_bookings params, @booked_room_ids, current_user.id
      flash[:success] = t ".success"
      redirect_to current_user
    else
      flash[:danger] = t ".fail"
      redirect_to book_path
    end
  end

  def edit; end

  def update
    if @booking.update booking_params
      flash[:success] = t ".booking_updated"
      redirect_to current_user
    else
      flash[:danger] = t ".update_fail"
      render :edit
    end
  end

  def delete; end

  def destroy
    @booking.destroy!

    flash[:success] = t ".booking_deleted"
    redirect_to current_user
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t ".delete_fail"
    redirect_to current_user
  end

  private

  def booking_params
    params.require(:booking).permit Booking::PERMITTED
  end

  def check_numberic
    @total = params.dig(:booking, :total).to_i
    return unless @total < 1

    flash[:danger] = t ".fail"
    redirect_to book_path
  end

  def booked_room_ids
    @booked_room_ids = Room.available
                           .by_room_type_id(params[:booking][:room_type])
                           .limit(@total)
                           .ids
    return if @booked_room_ids.present?

    flash[:danger] = t ".fail"
    redirect_to book_path
  end

  def check_change_booking
    return unless is_deadline_expired? @booking.created_at

    flash[:danger] = t ".errors.deadline_expired"
    redirect_to current_user
  end

  def load_booking
    id = params[:id].presence || params[:booking_id]
    @booking = Booking.find_by id: id
    return if @booking

    flash[:danger] = t ".errors.not_found"
    redirect_to current_user
  end
end
