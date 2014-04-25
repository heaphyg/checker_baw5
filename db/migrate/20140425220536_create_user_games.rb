class CreateUserGames < ActiveRecord::Migration
  def change
    create_table :user_games do |t|
      t.belongs_to :game
      t.belongs_to :user

      t.timestamps
    end
  end
end
