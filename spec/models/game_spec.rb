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

    context ".move_distance_calculation" do
      it "calulates the distance between start_loc and end_loc for a contiguous destination" do
        expect(Game.move_distance_calculation('51', '40')).to eq 1
      end

      it "calculates the distance between start_loc and end_loc for a jump" do
        expect(Game.move_distance_calculation('51', '33')).to eq 2
      end
    end

    context ".valid_move?" do
      it "method returns true if the move is valid (non jump move)" do
        expect(Game.valid_move?('51', '41')).to eq true
      end

      # it "method returns true if the move is valid (jump move)" do
      #   expect(Game.valid_move?('51', '33')).to eq true
      # end

      # it "method returns false if the move is invalid" do
      #   expect(Game.valid_move?('51', '43')).to eq false
      # end
    end
  end
 end







