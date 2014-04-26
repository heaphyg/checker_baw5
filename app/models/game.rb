class Game < ActiveRecord::Base
  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'
  belongs_to :loser, class_name: 'User', foreign_key: 'loser_id'
  has_many :user_games
  has_many :users, through: :user_games
  has_many :moves
  has_one :board
  has_many :pieces

  def self.empty_space?(end_loc) #must take a string
    Board.where(coord: end_loc).first.is_occupied
  end

  def self.move_distance_calculation(start_loc, end_loc, unique_piece_id)
    start_loc = start_loc.split('').map(&:to_i)
    end_loc = end_loc.split('').map(&:to_i)
    curr_row = start_loc[0]
    curr_col = start_loc[1]
    dest_row = end_loc[0]
    dest_col = end_loc[1]

    if (curr_row - dest_row).abs && (curr_col - dest_col).abs == 1
      move_dist = (curr_row - dest_row)
    elsif (curr_row - dest_row).abs && (curr_col - dest_col).abs == 2
      move_dist = (curr_row - dest_row)
    else
      return false
    end
    return (move_dist.abs * player_move_direction(unique_piece_id))
  end

  def self.player_move_direction(unique_piece_id)
    if unique_piece_id[0] == "R" # Red should be on top
      player_direction = -1
    else
      player_direction = 1
    end
  end

  def self.valid_row_dist?(start_loc, end_loc, move_dist)
    if move_dist
      end_loc[0].to_i == (start_loc[0].to_i - move_dist)
    else
      return false
    end
  end

  def self.valid_col_dist?(start_loc, end_loc, move_dist)
    if move_dist
      end_loc[1].to_i == (start_loc[1].to_i - move_dist.abs) || end_loc[1].to_i == (start_loc[1].to_i + move_dist.abs)
    else
      return false
    end
  end

  def self.valid_move?(unique_piece_id, start_loc, end_loc)
    move_dist = move_distance_calculation(start_loc, end_loc, unique_piece_id)
    if (valid_row_dist?(start_loc, end_loc, move_dist) == true) && (valid_col_dist?(start_loc, end_loc, move_dist) == true)
      return true
    else
      return false
    end
  end
end
