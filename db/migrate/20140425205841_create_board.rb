class CreateBoard < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :coord
      t.boolean :is_occupied
      t.belongs_to :game

      t.timestamps
    end
  end
end
