class CreateFriendrequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friendrequests do |t|
      t.string :friend_id

      t.timestamps
    end
  end
end
