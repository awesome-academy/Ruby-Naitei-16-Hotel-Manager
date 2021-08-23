class BookingsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :check_numberic, :booked_room_ids, only: %i(create update)

  def show; end

  def create
    params[:booking].except(:total, :room_type)
    if Booking.create_bookings params, @booked_room_ids, current_user.id
      flash[:success] = t ".success"
      redirect_to current_user
    else
      flash[:danger] = t ".fail"
      redirect_to booking_path
    end
  end

  def update; end

  def destroy; end

  private

  def check_numberic
    @total = params.dig(:booking, :total).to_i
    return unless @total < 1

    flash[:danger] = t ".fail"
    redirect_to booking_path
  end

  def booked_room_ids
    @booked_room_ids = Room.available
                           .by_room_type_id(params[:booking][:room_type])
                           .limit(@total)
                           .ids
    return if @booked_room_ids.present?

    flash[:danger] = t ".fail"
    redirect_to booking_path
  end
end
