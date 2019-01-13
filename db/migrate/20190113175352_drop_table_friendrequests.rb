class DropTableFriendrequests < ActiveRecord::Migration[5.2]
  def change
  	drop_table :friendrequests
  end
end
