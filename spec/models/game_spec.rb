require 'spec_helper'

describe Game do
  let(:game) { Game.new }

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




#   context "#empty_space?" do

#     it "returns true" do
#       expect(game.empty_space?([1,0])).to #true
#     end

#     it "returns false" do
#       expect().to #false
#     end
#   end
 end
