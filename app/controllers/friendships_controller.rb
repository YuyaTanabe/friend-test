class FriendshipsController < ApplicationController
  def new
  	@friendship = Friendship.new
  end

  def create
	friendship = Friendship.new(friendship_params)
	to_friend_id = friendship.friend_id
	# friendship.save
	# friend_fid = @friend.friend_id

	if
	  to_friend_id == current_user.friend_id
	  @friendship = Friendship.new
      flash[:notice] = "それはあなたのフレンドIDです"
	  render "new"

	elsif
	# to_user ＝ User.find_by(friend_id: friend_fid)
	# to_user ＝ User.find(friend_id: friend_id)
	# to_user = User.find(friendship.to_user_id)
	  to_user = User.find_by(friend_id: to_friend_id)
	# friendship.destroy

      if
        current_user.is_friend?(to_user)
        @friendship = Friendship.new
        flash[:notice] = to_user.user_name + "はすでにあなたのフレンドです"
	    render "new"
	  else

  	  # friendship.save(from_user_id: current_user.id, to_user_id: to_user.id, friend_id: to_user.friend_id)
	  # friendship.save(from_user_id: to_user.id, to_user_id: current_user.id, friend_id: current_user.friend_id)
	    friendship = Friendship.create(from_user_id: current_user.id, to_user_id: to_user.id, friend_id: to_user.friend_id)
	    friendship_back = Friendship.create(from_user_id: to_user.id, to_user_id: current_user.id, friend_id: current_user.friend_id)
        flash[:notice] = to_user.user_name + "はあなたのフレンドになりました"
	    redirect_to friendships_path
	  end
	else
	  @friendship = Friendship.new
      flash[:notice] = "そのフレンドIDは存在しません"
	  render "new"
	end
  end

  def index
  	@friendship = Friendship.where(from_user_id: current_user.id)
  	# @friendships = Friendship.all
  	# @from_users = User.all
  	# @from_users.id = @friendships.to_user_id


  end

  def destroy
    friendship = Friendship.find(params[:id])
    to_user = User.find(friendship.to_user_id)
    friendship_back = Friendship.find_by(from_user_id: to_user.id, to_user_id: current_user.id)
    friendship.destroy
    friendship_back.destroy
    flash[:notice] = to_user.user_name + "をフレンドから削除しました"
    redirect_to friendships_path
  end

    private
    def friendship_params
        params.require(:friendship).permit(:from_user_id, :to_user_id, :friend_id)
    end
end
