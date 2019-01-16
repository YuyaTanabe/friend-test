class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 同じmodelを参照する外部キーを一つのmodelでもつ方法
  # friendshipテーブルのfrom_user_idカラムまたはto_user_idカラムの値と同じidの値を持つユーザーを削除すると、friendshipテーブルのレコードも削除される
  has_many :from_user_transactions, class_name: 'Friendship', :foreign_key => 'from_user_id', dependent: :destroy
  has_many :to_user_transactions, class_name: 'Friendship', :foreign_key => 'to_user_id', dependent: :destroy

  has_many :locations, dependent: :destroy

  # 同じmodelを参照する外部キーを一つのmodelでもつ方法
  # roomテーブルのinvite_user_idカラムまたはinvited_user_idカラムの値と同じidの値を持つユーザーを削除すると、roomテーブルのレコードも削除される
  has_many :invite_user_transactions, class_name: 'Room', :foreign_key => 'invite_user_id', dependent: :destroy
  has_many :invited_user_transactions, class_name: 'Room', :foreign_key => 'invited_user_id', dependent: :destroy

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  # user(=入力したフレンドIDを持つユーザー)とすでにフレンド関係にあるかの確認
  def is_friend?(user)
    Friendship.where(from_user_id: self.id, to_user_id: user.id).exists?
  end

  # user(=ユーザーページのユーザー)との間でチャットルームが存在するかの確認
  def is_made?(user)
    first_friendship = Friendship.find_by(from_user_id: self.id, to_user_id: user.id)
    Room.where(friendship_id: first_friendship.id).exists?
    second_friendship = Friendship.find_by(from_user_id: user.id, to_user_id: self.id)
    Room.where(friendship_id: second_friendship.id).exists?
  end

  # user(=ユーザーページのユーザー)のIDとFriendshipのto_user_idが一致する場合に、そのFriendshipのIDを持つルームチャットが存在するかの確認
  def is_made_first?(user)
    first_friendship = Friendship.find_by(from_user_id: self.id, to_user_id: user.id)
    Room.where(friendship_id: first_friendship.id).exists?
  end

  # user(=ユーザーページのユーザー)のIDとFriendshipのfrom_user_idが一致する場合に、そのFriendshipのIDを持つルームチャットが存在するかの確認
  def is_made_second?(user)
    second_friendship = Friendship.find_by(from_user_id: user.id, to_user_id: self.id)
    Room.where(friendship_id: second_friendship.id).exists?
  end

end
