class StaticPagesController < ApplicationController
  def home
    @room_types = RoomType.most_available.limit(Settings.room_types.max_in_rows)
  end

  def booking
    @room_types = RoomType.most_available
  end

  def help; end
end
