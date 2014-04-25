class Game < ActiveRecord::Base
  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'
  belongs_to :loser, class_name: 'User', foreign_key: 'loser_id'
  has_many :user_games
  has_many :users, through: :user_games
  has_many :moves
  has_one :board
  has_many :pieces
end
