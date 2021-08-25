class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: :booking

  def home
    @room_types = RoomType.most_available.limit(Settings.room_types.max_in_rows)
  end

  def booking
    @room_types = RoomType.most_available
    @booking = Booking.new
  end

  def help; end
end
