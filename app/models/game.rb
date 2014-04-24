class Game < ActiveRecord::Base
	belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'
	belongs_to :loser, class_name: 'User', foreign_key: 'loser_id'
	has_many :usergames
	has_many :users, through: :usergames
	has_many :moves
end
