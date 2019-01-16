class AddColumnRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :invite_user_id, :integer
    add_column :rooms, :invited_user_id, :integer
  end
end
