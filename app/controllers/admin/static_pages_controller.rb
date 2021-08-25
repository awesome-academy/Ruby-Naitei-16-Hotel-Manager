class Admin::StaticPagesController < AdminController
  def home; end

  def book
    @room_types = RoomType.most_available
    @booking = Booking.new
  end

  def help; end
end
