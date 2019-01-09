class FriendshipsController < ApplicationController
  def new
  	@friendship = Friendship.new
  end

  def create
	friendship = Friendship.new(friendship_params)
	# friendship.save
	# friend_fid = @friend.friend_id

	# to_user ＝ User.find_by(friend_id: friend_fid)
	# to_user ＝ User.find(friend_id: friend_id)
	to_user = User.find(friendship.to_user_id)
	# friendship.destroy

	# friendship.save(from_user_id: current_user.id, to_user_id: to_user.id, friend_id: to_user.friend_id)
	# friendship.save(from_user_id: to_user.id, to_user_id: current_user.id, friend_id: current_user.friend_id)
	friendship = Friendship.create(from_user_id: current_user.id, to_user_id: to_user.id, friend_id: to_user.friend_id)
	friendship_back = Friendship.create(from_user_id: to_user.id, to_user_id: current_user.id, friend_id: current_user.friend_id)
	redirect_to users_path
  end

  def index
  	@friendship = Friendship.where(from_user_id: current_user.id)
  	# @friendships = Friendship.all
  	# @from_users = User.all
  	# @from_users.id = @friendships.to_user_id


  end

  def destroy
  end
    private
    def friendship_params
        params.require(:friendship).permit(:from_user_id, :to_user_id, :friend_id)
    end
end
