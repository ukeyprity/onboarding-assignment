
require './diceset'
require './gameplayer'


class Game
	player_add_score=0

	def initialize(players)
		raise ArgumentError, "'Number of players must be >= 1" unless players.is_a?(Array) && players.size > 0
		@players = players
		@dice_set = Dice.new
	end
	
	
	def startgame(player)
		throwflag=0

			p "                                                                                                                                      "
			p "start the turn with scoring- #{player.name}, #{player.score}"
			p "*************************************************************"
		game_score= 0
		#p " #{player.score}" #print the score
		number_of_throws = 5

		startgameflag = false
		if player.score >=300
			startgameflag = true

		end	

		loop do #score loop 

			

			throw_score, number_of_throws = Dice.score(@dice_set.rolling_the_dice(number_of_throws))
            # puts " #{throw_score} , #{game_score}"
			

			p " #{player.name} throw #{@dice_set.values} (#{throw_score})!"

			game_score = game_score+throw_score
			if (game_score >= 300) or player.score >= 300 #it was throw_score prev
			startgameflag = true
			end
			
			if throwflag ==0 and number_of_throws == 0
				number_of_throws=5
				throwflag =1
			else
				throwflag =1
			end

			if throw_score == 0 # No score loop
				p "Oh No-- NO SCORE "
				game_score = 0
				break
			end


			if number_of_throws ==0 
				 
				break
			   end #end of break if 
         

				if  startgameflag == true or game_score >=300
			
					#p " #{player.name} throw #{@dice_set.values} (#{throw_score}). Score of throw is: #{game_score}!"
					print "\t\tYou have #{number_of_throws} throw(s)! Continue? (y/n): "
					answer = gets.chop
						if answer =~ /^n/i
							player.add_to_score(game_score)
							#p "#{player.name} have #{player.score} score for this round"
							startgameflag= false
						break

						end
										

					else 
				end
             	
		    end 

			if startgameflag == true 
				player.add_to_score(game_score)
			end	
	
							#p "#{player.name} have #{player.score} score for this round"
							p "*************************************************************"
							p "end of the score of current turn- #{player.name}, #{player.score}"

		end

		def finalee #Winner check else play
			final_points = nil 
			while final_points.nil?
				@players.each do |player|
					startgame(player)
					if player.score >= 3000 # condition for final round
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

		
