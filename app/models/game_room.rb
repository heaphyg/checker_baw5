class GameRoom < ActiveRecord::Base
  has_many :players, class_name: "User", foreign_key: :user_id
end
