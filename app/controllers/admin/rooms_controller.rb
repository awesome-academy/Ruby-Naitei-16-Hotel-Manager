class Admin::RoomsController < AdminController
  def new
    @room = Room.new
  end

  def create
    @room = Room.new room_params
    if @room.save
      flash[:success] = t ".success"
      redirect_to @room
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  private
  def room_params
    params.require(:room).permit Room::ROOM_PERMITTED
  end
end
