class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # 同じmodelを参照する外部キーを一つのmodelでもつ方法
  has_many :from_user_transactions, class_name: 'Friendship', :foreign_key => 'from_user_id', dependent: :destroy
  has_many :to_user_transactions, class_name: 'Friendship', :foreign_key => 'to_user_id', dependent: :destroy

  has_many :locations, dependent: :destroy


  def is_friend?(user)
    Friendship.where(from_user_id: self.id, to_user_id: user.id).exists?
  end

end
