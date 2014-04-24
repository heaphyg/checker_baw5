class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
	has_secure_password
	has_many :usergames
	has_many :games, through: :usergames
end
