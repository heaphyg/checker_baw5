class Game < ActiveRecord::Base
	belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'
	belongs_to :loser, class_name: 'User', foreign_key: 'loser_id'
	has_many :usergames
	has_many :users, through: :usergames
	has_many :moves

  def empty_space?(end_loc)
    Board[end_loc[0]][end_loc[1]] == ''
  end

  def valid_move?(start_loc, end_loc)
    move_dist = calc_move_distance(start_loc, end_loc)
    curr_row = start_loc[0]
    curr_col = start_loc[1]
    dest_row = end_loc[0]
    dest_col = end_loc[1]

    if piece_color == "black" # black should be on top
      player_direction = -move_dist
    else
      player_direction = move_dist
    end

    if dest_row == (curr_row - player_direction) && dest_col == (curr_col + move_dist || curr_col - move_dist)
      return true
    else
      return false
    end
  end
end
