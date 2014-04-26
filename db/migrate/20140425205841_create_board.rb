class CreateBoard < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :unique_piece_id
      t.string :coord
      t.boolean :is_occupied
      t.belongs_to :game

      t.timestamps
    end
  end
end
