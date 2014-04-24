class Game < ActiveRecord::Base
	belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'
	belongs_to :loser, class_name: 'User', foreign_key: 'loser_id'
	has_many :usergames
	has_many :users, through: :usergames
	has_many :moves

  def empty_space?(end_loc)
    Board[end_loc[0]][end_loc[1]] == ''
  end

  def move_distance_calculation(start_loc, end_loc)
    curr_row = start_loc[0]
    curr_col = start_loc[1]
    dest_row = end_loc[0]
    dest_col = end_loc[1]

    if (curr_row - dest_row) == (curr_col - dest_col)
      move_dist = curr_row - dest_row
    end
    return move_dist
  end

  def valid_move?(start_loc, end_loc)
    move_dist = move_distance_calculation(start_loc, end_loc)
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

  def find_square_between_origin_and_destination(start_loc, end_loc)
    mid_row_sum = (start_loc[0] + end_loc[0])
    mid_row = mid_row_sum / 2
    mid_col_sum = (start_loc[1] + end_loc[1])
    mid_col = mid_col_sum / 2
    mid_square = [mid_row, mid_col]
  end

  def opponent_in_jump_midpoint?(start_loc, end_loc)
    midpoint = find_square_between_origin_and_destination(start_loc, end_loc)
    player = Board[start_loc[0]][start_loc[1]]

    true if player != midpoint && empty_space?(midpoint)
  end

  def game_over?(piece_id, game_id)
    opponent_color = Piece.find(piece_id).color
    game_moves = Moves.where(game_id: game_id)

    game_moves.each do |move|
      empty_positions = []

      if move.piece.color == opponent_color && move.postition == ''
        empty_position. << move.piece
      end

      if empty_positions.length == 12
        return true
      else
        return false
      end
    end
  end
end
