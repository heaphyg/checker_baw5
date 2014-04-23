class User < ActiveRecord::Base
	has_secure_password
	has_many :usergames
	has_many :games, through: :usergames
end
