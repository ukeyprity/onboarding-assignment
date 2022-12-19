# Initializing player

class Player # Class for player and score
	attr_reader :name, :score  

		def initialize(name) #initialize the player and score
			@name = name
			@score = 0
		end
		
		def add_to_score(number) 
			@score += number # appending of the scores
		end
end
