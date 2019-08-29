
  puts "Welcome to DPL Casino! What's your name?"
@user_name = gets.strip
puts "Thanks for choosing DPL Casino #{@user_name}! How much money would you like to play with today?"
cash = gets.chomp.to_i
loop do
 puts "Total cash: $#{cash}"
 puts "How much would you like to bet?"
 bet = gets.chomp.to_i
 cash -= bet

 init
  puts "Welcome to the game of Craps!"
   srand Time.now.tv_sec
 end

 def getroll
   2 + rand(6) + rand(6)
 end

 init
 roll1 = getroll
 puts "Your roll was" + roll1.to_s
   case roll1
   when 7, 11, 12
     puts "You win!"
       exit
   when 2, 3
     puts "Sorry, better luck next time!"
       exit
   else
     puts "Roll again!"
   end
 
   point = getroll
   puts "Point is " + point.to_s
   case point
     when 7
       puts "Sorry, better luck next time!"
     exit
     when roll1
       puts "You win!"
     exit
   end
    roll2 = 0
     while point != roll2
     roll2 = getroll
     puts "Your roll is " + roll2.to_s
     case roll2
       when 7
       puts "Sorry, better luck next time!"
     exit
       when point
       puts "You win!"
     exit
     else
       puts "Roll again"
     end
    end
    
