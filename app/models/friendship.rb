class Friendship < ApplicationRecord

  # 同じmodelを参照する外部キーを一つのmodelでもつ方法
  belongs_to :from_user, class_name: 'User', :foreign_key => 'from_user_id'
  belongs_to :to_user, class_name: 'User', :foreign_key => 'to_user_id'
end
