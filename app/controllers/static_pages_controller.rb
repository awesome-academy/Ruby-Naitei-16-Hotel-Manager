class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: :user_booking
  before_action :set_search

  def home
    @search_room_types = @q.result.limit(Settings.room_types.max_in_rows)
  end

  def user_booking
    params[:booking] ||= {}
    @search_room_types = @q.result
    @booking = Booking.new
  end

  def help; end

  private
  def set_search
    @room_types = RoomType.most_available
    @q = @room_types.ransack(name_cont: params[:search_key])
  end
end
