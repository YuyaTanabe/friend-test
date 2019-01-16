class Room < ApplicationRecord
  # 同じmodelを参照する外部キーを一つのmodelでもつ方法
  # roomテーブルのinvite_user_idカラムまたはinvited_user_idカラムの値と同じidの値を持つユーザーが削除されると、roomテーブルのレコードも削除される
  belongs_to :invite_user, class_name: 'User', :foreign_key => 'invite_user_id'
  belongs_to :invited_user, class_name: 'User', :foreign_key => 'invited_user_id'

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
end
