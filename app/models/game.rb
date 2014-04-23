class Game < ActiveRecord::Base
	belongs_to :winner, classname: 'User', foreign_key: 'winner_id'
	belongs_to :loser, classname: 'User', foreign_key: 'loser_id'
	has_many :usergames
	has_many :users, through: :usergames
	has_many :moves
end
