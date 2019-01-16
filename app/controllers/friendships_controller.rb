class FriendshipsController < ApplicationController
  def new
  	@friendship = Friendship.new
  end

  def create
	  friendship = Friendship.new(friendship_params)
	  to_friend_id = friendship.friend_id

  	if to_friend_id == current_user.friend_id
  	  @friendship = Friendship.new
        flash[:alert] = "それはあなたのフレンドIDです"
  	  render "new"
  	elsif
  	  to_user = User.find_by(friend_id: to_friend_id)

      if current_user.is_friend?(to_user)
        @friendship = Friendship.new
        flash[:alert] = to_user.user_name + "はすでにあなたのフレンドです"
	      render "new"
	    else
  	    friendship = Friendship.create(from_user_id: current_user.id, to_user_id: to_user.id, friend_id: to_user.friend_id)
  	    friendship_back = Friendship.create(from_user_id: to_user.id, to_user_id: current_user.id, friend_id: current_user.friend_id)
        flash[:notice] = to_user.user_name + "はあなたのフレンドになりました"
	      redirect_to friendships_path
	    end
	  else
  	  @friendship = Friendship.new
      flash[:alert] = "そのフレンドIDは存在しません"
  	  render "new"
	  end
  end

  def index
  	@friendship = Friendship.where(from_user_id: current_user.id)
  end

  def destroy
    friendship = Friendship.find(params[:id])
    to_user = User.find(friendship.to_user_id)
    friendship_back = Friendship.find_by(from_user_id: to_user.id, to_user_id: current_user.id)
    friendship.destroy
    friendship_back.destroy
    # フレンド関係を削除したときに、それに基づくチャットルームも削除する
    if Room.where(friendship_id: friendship.id).exists?
      first_room = Room.find_by(friendship_id: friendship.id)
      first_room.destroy
    else
      Room.where(friendship_id: friendship_back.id).exists?
      second_room = Room.find_by(friendship_id: friendship_back.id)
      second_room.destroy
    end
    flash[:notice] = to_user.user_name + "をフレンドから削除しました"
    redirect_to friendships_path
  end

  private
    def friendship_params
      params.require(:friendship).permit(:from_user_id, :to_user_id, :friend_id)
    end

end
