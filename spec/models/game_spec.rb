require 'spec_helper'

describe Game do
  # let(:game) { Game.new }

  # context "Game object instantiation" do  # we don't have an initialize method
  #   it "creates a GameController object" do
  #     expect(game).to be_an_instance_of Game
  #   end
  # end
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
      expect(Game.valid_move?('R11', '24', '35')).to eq true
    end

    it "should return false if the move is move is invalid top to bottom non-jump move" do
      expect(Game.valid_move?('R11', '24', '37')).to eq false
    end

    it "method returns true if the move is valid jump move" do
      expect(Game.valid_move?('R11', '24', '46')).to eq true
    end

    it "method returns false if the move is invalid jump move" do
      expect(Game.valid_move?('R11', '24', '57')).to eq false
    end
  end

  context ".valid_move? bottom to top" do
    it "should return true if the move is valid non-jump move" do
      expect(Game.valid_move?('B11', '53', '31')).to eq true
    end

    it "should return false if the move is move is invalid non-jump move" do
      expect(Game.valid_move?('B11', '53', '40')).to eq false
    end

    it "should return true if the move is valid jump move" do
      expect(Game.valid_move?('B11', '53', '31')).to eq true
    end

    it "should return false if the move is invalid jump move" do
      expect(Game.valid_move?('B11', '53', '22')).to eq false
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
end







