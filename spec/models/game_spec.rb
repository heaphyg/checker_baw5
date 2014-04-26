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
    it "returns true if the destination space is unoccupied" do
      expect(Game.empty_space?('31')).to eq false
    end
    it "returns false if the destination space is occupied" do
      expect(Game.empty_space?('00')).to eq true
    end
  end
 end
