class Move < ActiveRecord::Base
  validates :position, presence: true
  validates :game_id, presence: true
  validates :piece_id, presence: true
	belongs_to :piece
	belongs_to :game
end
