require 'spec_helper'

describe Game do
  let(:game) { Game.new }

  # context "Game object instantiation" do  # we don't have an initialize method
  #   it "creates a GameController object" do
  #     expect(game).to be_an_instance_of Game
  #   end
  # end

  it { should belong_to :winner }
  it { should belong_to :loser }
  it { should have_many :usergames }
  it { should have_many :users }
  it { should have_many :moves}


  context "#empty_space?" do

    it "returns true" do
      expect(game.empty_space?([1,0])).to #true
    end

    it "returns false" do
      expect().to #false
    end
  end
end
