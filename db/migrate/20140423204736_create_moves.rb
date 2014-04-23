class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.string :position
      t.belongs_to :piece
      t.belongs_to :game

      t.timestamps
    end
  end
end
