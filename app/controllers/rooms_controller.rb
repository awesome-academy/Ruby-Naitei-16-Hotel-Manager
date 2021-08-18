class RoomsController < ApplicationController
  before_action :is_admin?, only: %i(new create)

  def new
    @room = Room.new
  end

  def show
    @room = Room.find_by id: params[:id]
    if @room
      @room_type = RoomType.find_by id: @room.room_type_id
    else
      flash[:warning] = t ".not_found"
      redirect_to root_path
    end
  end

  def create
    @room = Room.new room_params
    @room.images.attach(params[:room][:images])
    if @room.save
      flash[:success] = t ".success"
      redirect_to @room
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  private
  def is_admin?
    return if current_user&.admin?

    flash[:warning] = t ".warning"
    redirect_to root_path
  end

  def room_params
    params.require(:room).permit Room::ROOM_PERMITTED
  end
end
