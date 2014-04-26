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

  def self.move_distance_calculation(start_loc, end_loc)
    start_loc = start_loc.split('').map(&:to_i)
    end_loc = end_loc.split('').map(&:to_i)
    curr_row = start_loc[0]
    curr_col = start_loc[1]
    dest_row = end_loc[0]
    dest_col = end_loc[1]

    if (curr_row - dest_row) == (curr_col - dest_col)
      move_dist = curr_row - dest_row
    else
      move_dist = 2
    end
    return move_dist
  end

    def self.valid_move?(start_loc, end_loc)
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


end
