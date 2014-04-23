# 2 users
2.times do 
	name = Faker::Name.name
	email = Faker::Internet.email
	User.create(name: name, email: email, password: 'password')
end


# 12 red adn 12 black pieces
12.times do
	Piece.create(color: 'black')
	Piece.create(color: 'red')
end

#######################



