class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :friendships, dependent: :destroy
  has_many :locations, dependent: :destroy


    # def friendshiped_by?(user)
    #   Friedship.find_by(from_user_id: user.id).exists?
    # end
  def is_friend?(user)
    Friendship.where(from_user_id: self.id, to_user_id: user.id).exists?
  end


end
