#Throw and score logic

require './diceset'
require './gameplayer'


class Game
	
	def initialize(players)
		raise ArgumentError, "'Number of players must be >= 1" unless players.is_a?(Array) && players.size > 0
		@players = players
		@dice_set = Dice.new
	end
	
	
	def startgame(player)
		game_score = 0
		p " #{player.score}" #print the score
		number_of_throws = 5
		loop do #score loop 
			throw_score, number_of_throws = Dice.score(@dice_set.rolling_the_dice(number_of_throws))
            # puts " #{throw_score} , #{game_score}"
             
			game_score = game_score+throw_score  # score will be added with throw

			p " #{player.name} throw #{@dice_set.values} (#{throw_score}). Score of throw is: #{game_score}!"
			if throw_score == 0 # No score loop
				p "Oh No-- NO SCORE "
				break
			end
           if number_of_throws ==0
            break
           end #end of break if 

			if game_score >= 300 	#more 300 is mandatory
            
				print "\t\tYou have #{number_of_throws} throw(s)! Continue? (y/n): "
				answer = gets.chop
				if answer =~ /^n/i
					player.add_to_score(game_score)
					p "#{player.name} have #{player.score} score."
                 break
			end
		end
		end 
	end

	def finalee #Winner check else play
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

		winners = []

        # Tie breaker
		winner = final_points  # final round
        loop do  # check for tie and winner
            winners.push(final_points)
            @players.each do |player| 
                if player != final_points
                    startgame(player)
                    if player.score == winner.score   #its a tie
                        winners.push(player)
                    
                    else
                    winner = player if player.score > winner.score #final winner check
                    end 
                end
            end
            if winners.length ==1 # to check logic till the time only one winner
                break
            else
                @players = winners
                winners = []    
            end   

        end    
		p "\n Hurray #{winner.name} wins by #{winner.score}"

        
	end

end

 playerslist = []
 playersnumber = 0

#playersnumber = gets.chop.to_i
 while playersnumber <2
	puts "\n kindly enter the number of players" # multiplayer
    playersnumber = gets.chop.to_i
    if playersnumber >=2
        break
    end
        puts"invalid entry"
    
 end
    

 while playersnumber >0
	puts "\n whats your name" # enter the name
    @myname = gets.chop
 playerslist.push(Player.new(@myname))
 playersnumber = playersnumber-1
 end
    game = Game.new(playerslist)
	game.finalee

		
