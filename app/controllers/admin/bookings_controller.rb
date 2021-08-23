class Admin::BookingsController < AdminController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :check_numberic, :booked_room_ids, only: :create
  before_action :load_booking, only: %i(destroy update edit)

  def index
    @bookings = Booking.all.page(params[:page])
  end

  def create
    params[:booking].except(:total, :room_type)
    if Booking.create_bookings params,
                               @booked_room_ids, params[:booking][:user_id]
      flash[:success] = t ".success"
      redirect_to admin_bookings_path
    else
      flash[:danger] = t ".fail"
      redirect_to admin_book_path
    end
  end

  def edit; end

  def update
    if @booking.update booking_params
      flash[:success] = t ".booking_updated"
      redirect_to admin_bookings_path
    else
      flash[:danger] = t ".update_fail"
      render :edit
    end
  end

  def destroy
    if @booking.destroy
      flash[:success] = t ".booking_deleted"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to admin_bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit Booking::PERMITTED
  end

  def check_numberic
    @total = params.dig(:booking, :total).to_i
    return unless @total < 1

    flash[:danger] = t ".fail"
    redirect_to admin_book_path
  end

  def booked_room_ids
    @booked_room_ids = Room.available
                           .by_room_type_id(params[:booking][:room_type])
                           .limit(@total)
                           .ids
    return if @booked_room_ids.present?

    flash[:danger] = t ".fail"
    redirect_to admin_bookings_path
  end

  def load_booking
    @booking = Booking.find_by id: params[:id]
    return if @booking

    flash[:danger] = t ".errors.not_found"
    redirect_to admin_path
  end
end
