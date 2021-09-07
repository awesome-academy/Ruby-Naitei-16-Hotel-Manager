class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: :user_booking
  before_action :set_search
  def home
    @room_types = @q.result.limit(Settings.room_types.max_in_rows)
  end

  def user_booking
    @room_types = @q.result
    @booking = Booking.new
  end

  def help; end

  private
  def set_search
    @q = RoomType.most_available.ransack(name_cont: params[:search_key])
  end
end
