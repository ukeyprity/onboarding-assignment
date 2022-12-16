

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
                print "#{key} ,#{value}"
            quantity = values.length
                    occurrences_hash = values.group_by(&:itself) #for the occurrences of the values
                                .transform_values(&:length)
                    occurrences_hash.each_pair do |number, occurrences|
                        print "\n #{number},#{occurrences}"
                    three_occurances, remaining_occurances = occurrences.divmod(3) # one can use % if needed
                    if number == 1 # always scoring number 1
                     score += three_occurances *1000 + remaining_occurances *100
                        elsif number == 5 # always scoring number 5
                         score += three_occurances *500 + remaining_occurances*50
                    else 
                        score += three_occurances *100*number
                    end
                    if(three_occurances == 1)
                        no_valuable = no_valuable-3
                    elsif remaining_occurances >1 and (number ==1 || number ==5)
                        no_valuable = no_valuable-remaining_occurances
                    end
                end
 			
     		#no_valuable = 5 if no_valuable == 0 #reset logic
			return score, no_valuable
        end
		end	
	end
end
