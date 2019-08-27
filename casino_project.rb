# casino account √

# TODO Random events occur when changing games that can increase or decrease player's bankroll
# TODO Find a gem that allows you to play sound and find casino sounds that will play on each game change/events

require 'colorize'

@account_balance = 0


def welcome
  puts "Welcome to the DPL Casino!"
  
  puts "What is your name?"
  @user_name = gets.strip
  puts "Hey #{@user_name.capitalize}, thanks for coming to the DPL Casino."
  lucky
end

def lucky
  puts "Are you feeling luck? (y/n)"
  @lucky = gets.strip
  if @lucky == "y"
    puts "Spinning..."
    @account_balance = rand(1..1000).to_f
    puts "Congrats! $#{@account_balance} has been added to your account!"
    separator
    menu
  elsif 
    menu
  else
    puts "Please type y or n" 
    lucky
  end

end

def menu
  puts "What would you like to do?"
  puts "1) View Your Casino Account"
  puts "2) See What Games to Play"
  puts "3) Leave Casino"
  @menu_choice = gets.to_i

  case @menu_choice
  when 1
    casino_account
  when 2
    if @account_balance > 0
     view_games
     else
      puts "You must deposit funds in your account before playing"   
      deposit
     end
  when 3
    exit_casino
  else
    puts "Please enter a valid choice"
    menu
  end
end

def casino_account
  puts "-- Casino Account --"
  puts "Please select from the choices below:"
  puts ""
  puts "1) View Account Balance"
  puts "2) Deposit Funds"
  puts "3) Withdraw Funds"
  puts "4) Return to Main Menu"
  @user_choice = gets.to_f

  case @user_choice
  when 1
    puts "Your account balance is $#{@account_balance}"
    separator
    casino_account
  when 2
    deposit
  when 3
    withdraw
  when 4
    menu
  else
    puts "Please enter a valid choice"
    menu
  end
  menu
end

def deposit
  puts "-- Deposit Center --"
  separator
  puts "How much would you like to deposit?"
  @deposit = gets.to_f
  @account_balance += @deposit
  separator
  puts "Your new balance is $#{@account_balance}"
  separator
  menu
end

def withdraw
  puts "-- Withdrawal Center --"
  separator
  puts "#{(@user_name).capitalize}, your balance is $#{@account_balance}"
  puts "How much would you like to withdraw?"
  @withdraw = gets.chomp.to_f
  if @withdraw > @account_balance
    puts "Sorry, not enough funds"
    separator
    withdraw
  elsif @withdraw <= @account_balance
    @account_balance -= @withdraw
    separator
    puts "Your remaining balance is $#{@account_balance}"
    separator
    menu
  else
    puts "Please enter a valid amount"
  end
end

def view_games
  puts "-- View Games --"
  separator
  puts "Choose a game to play"
  separator
  puts "1) Slots"
  puts "2) High/Low"
  puts "3) Main Menu"
  @game_choice = gets.to_f

  if @game_choice == 1
    slots
  elsif @game_choice == 2
    high_low
  elsif @game_choice == 3
    menu
  else
    puts "Sorry that wasn't an option.."
  end
end

def high_low
  @n1 = rand(1..10)
  @n2 = rand(1..10)
  puts "--Welcome to Hi/Lo--"
  separator
  puts "Your first number is #{@n1}"
  separator
  puts "Please enter your bet amount:"
  @bet1 = gets.chomp.to_f
  puts "Will the next number be higher or lower? (h/l)"
  @hl1 = gets.chomp
  separator
  puts "The next number is #{@n2}"
  case @hl1
  when "h"
    if @n2 > @n1
      @bet1 *= 0.5
      @account_balance += @bet1
        puts "Congratulations, you've won!"
        puts "Your new balance is $#{@account_balance}"
        separator
        puts "Would you like to play again? y/n"
        @choice2 = gets.chomp
          case @choice2
            when "y"
              high_low
            when "n"
              menu
            else
              puts "Please enter y or n"
          end
  
    elsif @n2 < @n1
      @account_balance -= @bet1
      puts "Sorry, you've lost"
      puts "Your new balance is $#{@account_balance}"
      separator
      puts "Would you like to play again? y/n"
      @choice3 = gets.chomp
        case @choice3
          when "y"
            high_low
          when "n"
            menu
          else
          puts "Please enter y or n"
        end
    else
      puts "The result is a push"
      separator
      puts "Would you like to play again? y/n"
      @choice4 = gets.chomp
        case @choice4
          when "y"
            high_low
          when "n"
            menu
          else
          puts "Please enter y or n"
        end
    end

  when "l"
    if @n2 > @n1
      @account_balance -= @bet1
      puts "Sorry, you've lost"
      puts "Your new balance is $#{@account_balance}"
      separator
      puts "Would you like to play again? y/n"
      @choice3 = gets.chomp
        case @choice3
          when "y"
            high_low
          when "n"
            menu
          else
          puts "Please enter y or n"
        end
  
    elsif @n2 < @n1
      @bet1 *= 0.5
      @account_balance += @bet1
        puts "Congratulations, you've won!"
        puts "Your new balance is $#{@account_balance}"
        separator
        puts "Would you like to play again? y/n"
        @choice2 = gets.chomp
          case @choice2
            when "y"
              high_low
            when "n"
              menu
            else
              puts "Please enter y or n"
          end
    else
      puts "The result is a push"
      puts "Would you like to play again? y/n"
      @choice4 = gets.chomp
        case @choice4
          when "y"
            high_low
          when "n"
            menu
          else
          puts "Please enter y or n"
        end
    end
  else
    separator
    puts "Please enter h or l"
    separator
    high_low
  end

end

def slots
 separator
 puts "-- Welcome to Slots --"
 separator
 puts "How much would you like to play with?"
 puts "Your balance is currently: #{@account_balance}"
 @slot_bet = gets.strip.to_f
 puts "Go ahead and press 'p' to pull the lever"
 @pull_lever = gets.strip
separator
if @pull_lever == "p"
 @myArray = ["stuff", "widget", "ruby", "goodies", "java" ]
 @item1 = @myArray.sample
 @item2 = @myArray.sample
 @item3 = @myArray.sample
puts "Spinning..."
separator
  puts "[ #{@item1} ] [ #{@item2} ]  [ #{@item3} ]" 
separator
  if @item1 == @item2 && @item1 == @item3 && @item2 == @item3
    puts "Hey you won!"
    @account_balance += @slot_bet
    puts "Your account balance is now $#{@account_balance}"
    play_again
  elsif @item1 == @item2 || @item1 == @item3 || @item2 == @item3
    puts "Hey you...kinda won!"
    @slot_bet = @slot_bet / 2
    @account_balance += @slot_bet
    puts "Your account balance is now $#{@account_balance}"
    play_again
  else
    puts "Sorry didn't win.."
    @account_balance -= @slot_bet
    puts "Your account balance is now $#{@account_balance}"
    play_again
  end
else
  puts "Press 'p' when you are ready to play"
end
end

def play_again
  separator
  puts "Would you like to play again? (y/n)"
  @play_again = gets.strip
  if @play_again == "y"
    slots
  elsif @play_again == "n"
    menu
  else
    "Sorry that wasn't an option.."
    play_again
  end
end

def exit_casino
  puts "-- Exiting --"
  separator
  if @account_balance > 0
  puts "Your taking home $#{@account_balance}. Way to go!"
  separator
  elsif @account_balance < 0
    puts "Sorry, you owe $#{@account_balance}"
    separator
    puts "Better luck next time.."
  else
    puts "Looks like you broke even today. Your balance is $#{@account_balance}"
  end
  separator
  puts "Thank you for playing at the DPL Casino!"
  exit
end

#   class Card
#     # Getter and Setter methods for rank, suit and color
#     attr_accessor :rank, :suit, :color
#     # Gets called when you call the new method to create an instance
#     # card = Card.new('10', 'Spades', 'Black')
#     def initialize(rank, suit, color)
#       @rank = rank
#       @suit = suit
#       @color = color
#     end
#    end

#    class Deck
#     # Getter and Setter methods for rank, suit and color
#     attr_accessor :cards
   
#     # Gets called when you call the new method to create an instance
#     # deck = Deck.new
#     def initialize
#       @ranks = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
#       @suits = %w(Spades Diamonds Clubs Hearts)
#       @cards = []
#       generate_deck
#     end
   
#     def shuffle_cards
#      @cards.shuffle
#     end
    
#     def generate_deck
#       @suits.each do |suit|
#         @ranks.size.times do |i|
#           # Ternary Operator
#           color = (suit == 'Spades' || suit == 'Clubs') ? 'Black' : 'Red' 
#           @cards << Card.new(@ranks[i], suit, color)
#         end
#       end
#       random_card
#     end

#     def random_card
#       rand_card = @cards.sample
#       puts "Here is your card: #{rand_card.rank}"
#        #{rand_card.suit} (#{rand_card.color}
#     end
   
#      def display_cards
#        @cards.shuffle.each do |card|
#          puts "#{card.rank} #{card.suit} (#{card.color})"
#        end
#      end
#    end

def separator
 puts " "
end



welcome