class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|

      t.timestamps
      t.integer :winner_id  ###
      t.integer :loser_id   ###
    end
  end
end
