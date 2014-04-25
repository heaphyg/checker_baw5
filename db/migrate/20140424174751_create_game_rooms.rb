class CreateGameRooms < ActiveRecord::Migration
  def change
    create_table :game_rooms do |t|
      t.string :room_name
      t.string :owner

      t.timestamps
    end
  end
end
