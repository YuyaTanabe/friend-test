class RemoveColumnRooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :rooms, :from_user_id, :integer
    remove_column :rooms, :to_user_id, :integer
  end
end
