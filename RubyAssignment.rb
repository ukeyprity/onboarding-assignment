# Greed game

class Player # Class for player and score
	attr_reader :player, :score  
	def initialize(player) #initialize the player and score
		@player = player
		@score = 0
	end
	def add_to_score(number) 
		@score += number # appending of the scores
	end
end

# Logic for the scores of the rolls
class Dice
	attr_reader :values 
	def initialize
		@values = Array.new
	end
	def rolling_the_dice(number)
		@values.clear #clear before start
		number.times { @values << rand(6) + 1 } #randomly generated values
		@values
	end
	class << self 
		def score(values) 
			score = 0
            no_valuable = values.size
            values.group_by {|number| number}.each do |key, value|
            quantity = values.length
                    occurrences_hash = values.group_by(&:itself) #for the occurrences of the values
                                .transform_values(&:length)
                    occurrences_hash.each_pair do |number, occurrences|
                    three_occurances, remaining_occurances = occurrences.divmod(3) # one can use % if needed
                    if number == 1 # always scoring number 1
                     score += three_occurances *1000 + remaining_occurances *100
                        elsif number == 5 # always scoring number 5
                         score += three_occurances *500 + remaining_occurances*50
                    else 
                        score += three_occurances *100*number
                    end
                end
 end
			no_valuable = 5 if no_valuable == 0 #restore
			return score, no_valuable
		end	
	end
end

# Lets begin.....
class Game
	def initialize(players)
		@players = players
		@dice_set = Dice.new
	end
	def startgame(player)
		game_score = 0
		p " #{player.score}" #print the score
		number_of_throws = 5
		loop do #score loop 
			throw_score, number_of_throws = Dice.score(@dice_set.rolling_the_dice(number_of_throws))
			game_score += throw_score  # score will be added with throw
			p "\n #{player.player} throw #{@dice_set.values} (#{throw_score}). Score of throw is: #{game_score}!"
			if throw_score == 0 # No score loop
				p "You made a boo boo -- NO SCORE"
				break
			end
           
			if game_score >= 300 	#more 300 is mandatory
					player.add_to_score(game_score)
					p "#{player.player} have #{player.score} score."
					
            else
                 break
			end
            
		end 
	end

	def finalee #game to play
		final_points = nil 
		while final_points.nil?
			@players.each do |player|
				startgame(player)
				if player.score > 3000 # condition for final round
					final_points = player
					break 
				end
			end 
		end 
		winner = final_points  # final round
		@players.each do |player| 
			if player != final_points
				startgame(player)
				winner = player if player.score > winner.score #final winner check
			end 
		end
		p " #{winner.player} wins"
	end
end

game = Game.new([Player.new("prity"), Player.new("ajesh")])
game.finalee
