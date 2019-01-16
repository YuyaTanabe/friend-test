class RoomsController < ApplicationController

  def index
    # @rooms = Room.all
    @entries = current_user.entries
  end

  def show
    if user_signed_in?
      @room = Room.find(params[:id])
      if Entry.where(user_id: current_user.id, room_id: @room.id).present?
        @messages = @room.messages
        @message = Message.new
        @entries = @room.entries
      else
        @user = User.find_by(id: current_user.id)
        redirect_to user_path(@user.id)
        flash[:alert] = "そのページへは行けません"
      end
    else
      redirect_to root_path
    end
  end

  def create
    room = Room.new(room_params)
    entry = Entry.new(entry_params)
    user = User.find_by(id: entry.user_id)
    if current_user.is_made_first?(user)
      first_friendship = Friendship.find_by(from_user_id: current_user.id, to_user_id: user.id)
      first_room = Room.find_by(friendship_id: first_friendship.id)
      redirect_to room_path(first_room.id)
    elsif
      current_user.is_made_second?(user)
      second_friendship = Friendship.find_by(from_user_id: user.id, to_user_id: current_user.id)
      second_room = Room.find_by(friendship_id: second_friendship.id)
      redirect_to room_path(second_room.id)
    else
      room.save
      entry1 = Entry.create(:room_id => room.id, :user_id => current_user.id)
      entry2 = Entry.create(:room_id => room.id, :user_id => entry.user_id)
      redirect_to room_path(room.id)
      flash[:notice] = "チャットルームを作成しました！"
    end
  end

  def edit
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
    else
      @user = User.find_by(id: current_user.id)
      redirect_to user_path(@user.id)
      flash[:alert] = "そのページへは行けません"
    end
  end

  def update
    room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: room.id).present?
      room.update(room_params)
      redirect_to room_path(room.id)
      flash[:notice] = room.room_name + "の情報を変更しました"
    else
      @user = User.find_by(id: current_user.id)
      redirect_to user_path(@user.id)
      flash[:alert] = "そのページへは行けません"
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    if room.room_name != nil
      flash[:alert] = "チャットルーム" + room.room_name + "を削除しました"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "チャットルームを削除しました"
      redirect_to user_path(current_user)
    end
  end

  private
    def room_params
      params.require(:room).permit(:room_name, :room_explanation, :friendship_id, :invite_user_id, :invited_user_id)
    end

    def entry_params
      params.require(:entry).permit(:room_id, :user_id)
    end

end
