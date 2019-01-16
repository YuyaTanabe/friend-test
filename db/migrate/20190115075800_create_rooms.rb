class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :room_name
      t.text :room_explanation
      t.integer :friendship_id

      t.timestamps
    end
  end
end
