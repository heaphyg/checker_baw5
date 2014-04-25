class User < ActiveRecord::Base
  has_many :usergames
  has_many :games, through: :usergames
end
