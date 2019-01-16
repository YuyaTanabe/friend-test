class Friendship < ApplicationRecord
  # 同じmodelを参照する外部キーを一つのmodelでもつ方法
  # friendshipテーブルのfrom_user_idカラムまたはto_user_idカラムの値と同じidの値を持つユーザーが削除されると、friendshipテーブルのレコードも削除される
  belongs_to :from_user, class_name: 'User', :foreign_key => 'from_user_id'
  belongs_to :to_user, class_name: 'User', :foreign_key => 'to_user_id'
end
