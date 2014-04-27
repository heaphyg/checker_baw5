class Game < ActiveRecord::Base
  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'
  belongs_to :loser, class_name: 'User', foreign_key: 'loser_id'
  has_many :user_games
  has_many :users, through: :user_games
  has_many :moves
  has_one :board
  has_many :pieces

  def self.empty_space?(coord) #must take a string
    square = Board.where(coord: coord).first
    if square && square.is_occupied
      return false
    elsif square && !square.is_occupied
      return true
    end
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

  def self.valid_move?(start_loc, end_loc, unique_piece_id)
    move_dist = move_distance_calculation(start_loc, end_loc, unique_piece_id)
    if (valid_row_dist?(start_loc, end_loc, move_dist) == true) && (valid_col_dist?(start_loc, end_loc, move_dist) == true)
      return true
    else
      return false
    end
  end

  def self.find_square_between_origin_and_destination(start_loc, end_loc)
    start_loc = start_loc.split('').map(&:to_i)
    end_loc = end_loc.split('').map(&:to_i)
    mid_row = (start_loc[0] + end_loc[0]) / 2
    mid_col = (start_loc[1] + end_loc[1]) / 2
    return "#{mid_row}#{mid_col}"
  end

  def self.opponent_in_jump_midpoint?(start_loc, end_loc, unique_piece_id)
    midpoint_coord = find_square_between_origin_and_destination(start_loc, end_loc)
    player_color = unique_piece_id.split('').shift

    if empty_space?(midpoint_coord) == true
      return false
    else
      midpoint_player_color = Piece.where(location: midpoint_coord).first.unique_piece_id.split('').shift
      if player_color == midpoint_player_color
        return false
      else
        return true
      end
    end
  end

  def self.initialize_board(game_id)
    Board.create(coord:'00', is_occupied: true, game_id: game_id)
    Board.create(coord:'02', is_occupied: true, game_id: game_id)
    Board.create(coord:'04', is_occupied: true, game_id: game_id)
    Board.create(coord:'06', is_occupied: true, game_id: game_id)
    Board.create(coord:'11', is_occupied: true, game_id: game_id)
    Board.create(coord:'13', is_occupied: true, game_id: game_id)
    Board.create(coord:'15', is_occupied: true, game_id: game_id)
    Board.create(coord:'17', is_occupied: true, game_id: game_id)
    Board.create(coord:'20', is_occupied: true, game_id: game_id)
    Board.create(coord:'22', is_occupied: true, game_id: game_id)
    Board.create(coord:'24', is_occupied: true, game_id: game_id)
    Board.create(coord:'26', is_occupied: true, game_id: game_id)
    Board.create(coord:'30', is_occupied: false, game_id: game_id)
    Board.create(coord:'31', is_occupied: false, game_id: game_id)
    Board.create(coord:'32', is_occupied: false, game_id: game_id)
    Board.create(coord:'33', is_occupied: false, game_id: game_id)
    Board.create(coord:'34', is_occupied: false, game_id: game_id)
    Board.create(coord:'35', is_occupied: false, game_id: game_id)
    Board.create(coord:'36', is_occupied: false, game_id: game_id)
    Board.create(coord:'37', is_occupied: false, game_id: game_id)
    Board.create(coord:'40', is_occupied: false, game_id: game_id)
    Board.create(coord:'41', is_occupied: false, game_id: game_id)
    Board.create(coord:'42', is_occupied: false, game_id: game_id)
    Board.create(coord:'43', is_occupied: false, game_id: game_id)
    Board.create(coord:'44', is_occupied: false, game_id: game_id)
    Board.create(coord:'45', is_occupied: false, game_id: game_id)
    Board.create(coord:'46', is_occupied: false, game_id: game_id)
    Board.create(coord:'47', is_occupied: false, game_id: game_id)
    Board.create(coord:'51', is_occupied: true, game_id: game_id)
    Board.create(coord:'53', is_occupied: true, game_id: game_id)
    Board.create(coord:'55', is_occupied: true, game_id: game_id)
    Board.create(coord:'57', is_occupied: true, game_id: game_id)
    Board.create(coord:'60', is_occupied: true, game_id: game_id)
    Board.create(coord:'62', is_occupied: true, game_id: game_id)
    Board.create(coord:'64', is_occupied: true, game_id: game_id)
    Board.create(coord:'66', is_occupied: true, game_id: game_id)
    Board.create(coord:'71', is_occupied: true, game_id: game_id)
    Board.create(coord:'73', is_occupied: true, game_id: game_id)
    Board.create(coord:'75', is_occupied: true, game_id: game_id)
    Board.create(coord:'77', is_occupied: true, game_id: game_id)
    # Top player (Red)
    Piece.create(location: '00', is_king: false, game_id: game_id, unique_piece_id: 'R1')
    Piece.create(location: '02', is_king: false, game_id: game_id, unique_piece_id: 'R2')
    Piece.create(location: '04', is_king: false, game_id: game_id, unique_piece_id: 'R3')
    Piece.create(location: '06', is_king: false, game_id: game_id, unique_piece_id: 'R4')
    Piece.create(location: '11', is_king: false, game_id: game_id, unique_piece_id: 'R5')
    Piece.create(location: '13', is_king: false, game_id: game_id, unique_piece_id: 'R6')
    Piece.create(location: '15', is_king: false, game_id: game_id, unique_piece_id: 'R7')
    Piece.create(location: '17', is_king: false, game_id: game_id, unique_piece_id: 'R8')
    Piece.create(location: '20', is_king: false, game_id: game_id, unique_piece_id: 'R9')
    Piece.create(location: '22', is_king: false, game_id: game_id, unique_piece_id: 'R10')
    Piece.create(location: '24', is_king: false, game_id: game_id, unique_piece_id: 'R11')
    Piece.create(location: '26', is_king: false, game_id: game_id, unique_piece_id: 'R12')
    # Bottom player (Black)
    Piece.create(location: '51', is_king: false, game_id: game_id, unique_piece_id: 'B12')
    Piece.create(location: '53', is_king: false, game_id: game_id, unique_piece_id: 'B11')
    Piece.create(location: '55', is_king: false, game_id: game_id, unique_piece_id: 'B10')
    Piece.create(location: '57', is_king: false, game_id: game_id, unique_piece_id: 'B9')
    Piece.create(location: '60', is_king: false, game_id: game_id, unique_piece_id: 'B8')
    Piece.create(location: '62', is_king: false, game_id: game_id, unique_piece_id: 'B7')
    Piece.create(location: '64', is_king: false, game_id: game_id, unique_piece_id: 'B6')
    Piece.create(location: '66', is_king: false, game_id: game_id, unique_piece_id: 'B5')
    Piece.create(location: '71', is_king: false, game_id: game_id, unique_piece_id: 'B4')
    Piece.create(location: '73', is_king: false, game_id: game_id, unique_piece_id: 'B3')
    Piece.create(location: '75', is_king: false, game_id: game_id, unique_piece_id: 'B2')
    Piece.create(location: '77', is_king: false, game_id: game_id, unique_piece_id: 'B1')
  end
end
