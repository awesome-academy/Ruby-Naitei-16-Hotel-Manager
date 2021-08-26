class Admin::RoomsController < AdminController
  before_action :load_room, except: %i(new create)

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

  def edit; end

  def show
    @room_type = RoomType.find_by id: @room.room_type_id
    render "rooms/show"
  end

  def update
    if @room.update room_params
      flash[:success] = t ".success"
      redirect_to @room
    else
      flash[:danger] = t ".fail"
      render :edit
    end
  end

  def destroy
    if @room.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to admin_path
  end

  private
  def room_params
    params.require(:room).permit Room::ROOM_PERMITTED
  end

  def load_room
    @room = Room.find_by id: params[:id]
    return if @room

    flash[:danger] = t ".not_found"
    redirect_to admin_path
  end
end
