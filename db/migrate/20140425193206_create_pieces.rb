class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :unique_piece_id
      t.string :location
      t.boolean :is_king
      t.belongs_to :game
      t.timestamps
    end
  end
end
