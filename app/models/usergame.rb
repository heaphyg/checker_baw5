class Usergame < ActiveRecord::Base
	belongs_to :User
	belongs_to :Game 
end
