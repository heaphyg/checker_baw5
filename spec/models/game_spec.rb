require 'spec_helper'

describe Game do
  it { should have_db_column(:winner_id).of_type(:integer) }
  it { should have_db_column(:loser_id).of_type(:integer) }

  it { should belong_to :winner }
  it { should belong_to :loser }
  it { should have_many :user_games }
  it { should have_many :users }
  it { should have_many :moves }
  it { should have_many :pieces }
  it { should have_one :board }




  context ".empty_space?" do
    Board.create(coord:'31', is_occupied: false, game_id: 1)
    Board.create(coord:'00', is_occupied: true, game_id: 1)

    it "method returns false if the destination space is unoccupied" do
      expect(Game.empty_space?('31')).to eq false
    end
    it "method returns true if the destination space is occupied" do
      expect(Game.empty_space?('00')).to eq true
    end
  end

  context ".move_distance_calculation" do
    it "should return positive one" do
      expect(Game.move_distance_calculation('51', '40', 'B12')).to eq 1
    end
    it "should return positive two" do
      expect(Game.move_distance_calculation('51', '33', 'B12')).to eq 2
    end
    it "should return negative one" do
      expect(Game.move_distance_calculation('26', '37', 'R12')).to eq -1
    end
    it "should return negative two" do
      expect(Game.move_distance_calculation('26', '44', 'R12')).to eq -2
    end
    it "should return false" do
      expect(Game.move_distance_calculation('26', '53', 'R12')).to eq false
    end
    it "should return false" do
      expect(Game.move_distance_calculation('53', '26', 'R12')).to eq false
    end
  end

  context ".valid_row_dist? for top to bottom" do
    it "should return true if destination row index equals the starting row index plus the move distance" do
      expect(Game.valid_row_dist?('24', '35', -1)).to eq true
    end
    it "should return false if destination row index does not equal the starting row index plus the move distance" do
      expect(Game.valid_row_dist?('24', '37', false)).to eq false
    end
  end

  context ".valid_row_dist? for bottom to top" do
    it "should return true if destination row index equals the starting row index plus the move distance" do
      expect(Game.valid_row_dist?('53', '44', 1)).to eq true
    end
    it "should return false if destination row index does not equal the starting row index plus the move distance" do
      expect(Game.valid_row_dist?('53', '40', false)).to eq false
    end
  end

  context ".valid_col_dist? for top to bottom" do
    it "should return true if destination column index equals the starting column index plus the move distance" do
      expect(Game.valid_col_dist?('24', '35', -1)).to eq true
    end
    it "should return false if destination column index does not equal the starting column index plus the move distance" do
      expect(Game.valid_col_dist?('24', '37', -1)).to eq false
    end
  end

  context ".valid_col_dist for bottom to top" do
    it "should return true if destination column index equals the starting column index plus the move distance" do
      expect(Game.valid_col_dist?('53', '44', 1)).to eq true
    end
    it "should return false if destination column index does not equal the starting column index plus the move distance" do
      expect(Game.valid_col_dist?('53', '40', 1)).to eq false
    end
  end

  context ".valid_move? top to bottom" do
    it "should return true if the move is valid top to bottom non-jump move" do
      expect(Game.valid_move?('24', '35', 'R11')).to eq true
    end

    it "should return false if the move is move is invalid top to bottom non-jump move" do
      expect(Game.valid_move?('24', '37', 'R11')).to eq false
    end

    it "method returns true if the move is valid jump move" do
      expect(Game.valid_move?('24', '46', 'R11')).to eq true
    end

    it "method returns false if the move is invalid jump move" do
      expect(Game.valid_move?('24', '57', 'R11')).to eq false
    end
  end

  context ".valid_move? bottom to top" do
    it "should return true if the move is valid non-jump move" do
      expect(Game.valid_move?('53', '31', 'B11')).to eq true
    end

    it "should return false if the move is move is invalid non-jump move" do
      expect(Game.valid_move?('53', '40', 'B11')).to eq false
    end

    it "should return true if the move is valid jump move" do
      expect(Game.valid_move?('53', '31', 'B11')).to eq true
    end

    it "should return false if the move is invalid jump move" do
      expect(Game.valid_move?('53', '22', 'B11')).to eq false
    end
  end

  context ".player_move_direction" do
    it "should return a positive integer if the player is Red" do
      expect(Game.player_move_direction('R11')).to eq -1
    end
    it "should return a positive integer if the player is Black" do
      expect(Game.player_move_direction('B11')).to eq 1
    end
  end

  context ".find_square_between_origin_and_destination" do
    it "should return the coord of the square between the start and end locations during a jump move" do
      expect(Game.find_square_between_origin_and_destination('53', '31')).to eq '42'
    end
    it "should return the coord of the square between the start and end locations during a jump move" do
      expect(Game.find_square_between_origin_and_destination('24', '46')).to eq '35'
    end
    it "should return the coord of the square between the start and end locations during a jump move" do
      expect(Game.find_square_between_origin_and_destination('26', '44')).to eq '35'
    end
  end

  context ".opponent_in_jump_midpoint?" do
    Board.create(coord:'00', is_occupied: true, game_id: 1)
    Board.create(coord:'02', is_occupied: true, game_id: 1)
    Board.create(coord:'04', is_occupied: true, game_id: 1)
    Board.create(coord:'06', is_occupied: true, game_id: 1)
    Board.create(coord:'11', is_occupied: true, game_id: 1)
    Board.create(coord:'13', is_occupied: true, game_id: 1)
    Board.create(coord:'15', is_occupied: true, game_id: 1)
    Board.create(coord:'17', is_occupied: true, game_id: 1)
    Board.create(coord:'20', is_occupied: true, game_id: 1)
    Board.create(coord:'22', is_occupied: true, game_id: 1)
    Board.create(coord:'24', is_occupied: true, game_id: 1)
    Board.create(coord:'26', is_occupied: true, game_id: 1)
    Board.create(coord:'30', is_occupied: false, game_id: 1)
    Board.create(coord:'31', is_occupied: false, game_id: 1)
    Board.create(coord:'32', is_occupied: false, game_id: 1)
    Board.create(coord:'33', is_occupied: false, game_id: 1)
    Board.create(coord:'34', is_occupied: false, game_id: 1)
    Board.create(coord:'35', is_occupied: false, game_id: 1)
    Board.create(coord:'36', is_occupied: false, game_id: 1)
    Board.create(coord:'37', is_occupied: false, game_id: 1)
    Board.create(coord:'40', is_occupied: false, game_id: 1)
    Board.create(coord:'41', is_occupied: false, game_id: 1)
    Board.create(coord:'42', is_occupied: false, game_id: 1)
    Board.create(coord:'43', is_occupied: false, game_id: 1)
    Board.create(coord:'44', is_occupied: false, game_id: 1)
    Board.create(coord:'45', is_occupied: false, game_id: 1)
    Board.create(coord:'46', is_occupied: false, game_id: 1)
    Board.create(coord:'47', is_occupied: false, game_id: 1)
    Board.create(coord:'51', is_occupied: true, game_id: 1)
    Board.create(coord:'53', is_occupied: true, game_id: 1)
    Board.create(coord:'55', is_occupied: true, game_id: 1)
    Board.create(coord:'57', is_occupied: true, game_id: 1)
    Board.create(coord:'60', is_occupied: true, game_id: 1)
    Board.create(coord:'62', is_occupied: true, game_id: 1)
    Board.create(coord:'64', is_occupied: true, game_id: 1)
    Board.create(coord:'66', is_occupied: true, game_id: 1)
    Board.create(coord:'71', is_occupied: true, game_id: 1)
    Board.create(coord:'73', is_occupied: true, game_id: 1)
    Board.create(coord:'75', is_occupied: true, game_id: 1)
    Board.create(coord:'77', is_occupied: true, game_id: 1)
    # Top player (Red)
    Piece.create(location: '00', is_king: false, game_id: 1, unique_piece_id: 'R1')
    Piece.create(location: '02', is_king: false, game_id: 1, unique_piece_id: 'R2')
    Piece.create(location: '04', is_king: false, game_id: 1, unique_piece_id: 'R3')
    Piece.create(location: '06', is_king: false, game_id: 1, unique_piece_id: 'R4')
    Piece.create(location: '11', is_king: false, game_id: 1, unique_piece_id: 'R5')
    Piece.create(location: '13', is_king: false, game_id: 1, unique_piece_id: 'R6')
    Piece.create(location: '15', is_king: false, game_id: 1, unique_piece_id: 'R7')
    Piece.create(location: '17', is_king: false, game_id: 1, unique_piece_id: 'R8')
    Piece.create(location: '20', is_king: false, game_id: 1, unique_piece_id: 'R9')
    Piece.create(location: '33', is_king: false, game_id: 1, unique_piece_id: 'R10')
    Piece.create(location: '35', is_king: false, game_id: 1, unique_piece_id: 'R11')
    Piece.create(location: '26', is_king: false, game_id: 1, unique_piece_id: 'R12')
    # Bottom player (Black)
    Piece.create(location: '51', is_king: false, game_id: 1, unique_piece_id: 'B12')
    Piece.create(location: '53', is_king: false, game_id: 1, unique_piece_id: 'B11')
    Piece.create(location: '44', is_king: false, game_id: 1, unique_piece_id: 'B10')
    Piece.create(location: '46', is_king: false, game_id: 1, unique_piece_id: 'B9')
    Piece.create(location: '60', is_king: false, game_id: 1, unique_piece_id: 'B8')
    Piece.create(location: '62', is_king: false, game_id: 1, unique_piece_id: 'B7')
    Piece.create(location: '64', is_king: false, game_id: 1, unique_piece_id: 'B6')
    Piece.create(location: '66', is_king: false, game_id: 1, unique_piece_id: 'B5')
    Piece.create(location: '71', is_king: false, game_id: 1, unique_piece_id: 'B4')
    Piece.create(location: '73', is_king: false, game_id: 1, unique_piece_id: 'B3')
    Piece.create(location: '75', is_king: false, game_id: 1, unique_piece_id: 'B2')
    Piece.create(location: '77', is_king: false, game_id: 1, unique_piece_id: 'B1')

    it "should return true if the square being jumped is occupied by the opponent's piece" do
      expect(Game.opponent_in_jump_midpoint?('35', '57', 'R11')).to eq true
    end
    it "should return true if the square being jumped is occupied by the opponent's piece" do
      expect(Game.opponent_in_jump_midpoint?('44', '22', 'B10')).to eq true
    end
    it "should return false if the square is empty" do
      expect(Game.opponent_in_jump_midpoint?('20', '42', 'R9')).to eq false
    end
    it "should return false if the square has the player's own piece" do
      expect(Game.opponent_in_jump_midpoint?('60', '42', 'B8')).to eq false
    end
  end
end






