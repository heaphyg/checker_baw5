class CreateGameRoom < ActiveRecord::Migration
  def change
    create_table :game_rooms do |t|
      t.string :room_name
      t.belongs_to :game
      t.belongs_to :user

    end
  end
end
