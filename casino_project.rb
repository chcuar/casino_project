
@user_name
@cchoice
@account_balance

def welcome
  puts "Welcome to DPL Casino"
  separator
  puts "Please enter your name"
  @user_name = gets.strip
  separator
  puts "Hello #{(@user_name).capitalize}, thank you for choosing DPL Casino!"
  lucky
end

def lucky
puts "Are you feeling lucky? y/n"
@lucky = gets.chomp
  if @lucky == "y"
    puts "...Spinning..."
    separator
    @account_balance = rand(1...1000).to_f
    puts "Congrats! #{@account_balance} has been added to your account!"
    menu
  elsif @lucky == "n"
    menu
  else
    puts "Please enter y or n"
  end
end

def separator
  puts " "
end

def menu
  puts "What would you like to do today?"
    puts "1) View Your Casino Account"
    puts "2) Choose Game"
    puts "3) Leave Casino"
   
    @cchoice = gets.to_i
    
    case @cchoice
    when 1
      separator
      casino_account
      separator
    when 2
      view_games
      separator
    when 3
      exit_casino
    else
      separator
      puts "Please enter a valid choice"
      separator
      menu
    end
  end

  def casino_account
    puts "Casino Account"
    separator
    puts "Please select from the choices below"
    puts "1) View Account Balance"
    puts "2) Deposit Funds"
    puts "3) Withdraw Funds"
    puts "4) Return to Main Menu"
    @user_choice = gets.chomp.to_i
    case @user_choice
      when 1
        puts "Your Account Balance is #{@account_balance}"
        separator
      when 2
        deposit
        separator
      when 3
        withdraw
        separator
      when 4
        menu
      else
        separator
        puts "Please enter a valid choice"
        separator
        menu
      end
  
  end

  def view_games
    puts "Casino Games"
    separator
    puts "Please choose a game below:"
    puts "1) Slots"
    puts "2) High/Low"
    puts "3) Main Menu"
    @game_choice = gets.chomp.to_i

    if @game_choice == 1
      slots
    elsif @game_choice == 2
      high_low
    elsif @game_choice == 3
      menu
    else
      separator
      puts "Please enter a valid choice"
      view_games
    end
  end

  def exit_casino
    puts "Exiting"
    separator
    puts "Your Account Balance is #{@account_balance}"
    puts "See You Soon!"
    Exit
  end

  def deposit
    puts "Deposit Center"
    separator
    puts "How much would you like to deposit?"
    @deposit = gets.to_f
    @account_balance += @deposit
    separator
    puts "Your new balance is $#{@account_balance}"
    menu
  end

  def withdraw
    puts "Withdrawal Center"
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

  def high_low
    puts "Welcome to Hi/Lo"
    separator
    @card1 = Deck.new
    separator
    puts "Please enter your bet amount:"
    @bet1 = gets.chomp.to_f
    puts "Will the next card be higher or lower? (h/l)"
    @hl1 = gets.chomp
    separator
    @card2 = Deck.new
    case @hl1
    when "h"
      

    when "l"

    

 
  end

  class Card
    # Getter and Setter methods for rank, suit and color
    attr_accessor :rank, :suit, :color
    # Gets called when you call the new method to create an instance
    # card = Card.new('10', 'Spades', 'Black')
    def initialize(rank, suit, color)
      @rank = rank
      @suit = suit
      @color = color
    end
   end

   class Deck
    # Getter and Setter methods for rank, suit and color
    attr_accessor :cards
   
    # Gets called when you call the new method to create an instance
    # deck = Deck.new
    def initialize
      @ranks = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
      @suits = %w(Spades Diamonds Clubs Hearts)
      @cards = []
      generate_deck
    end
   
    def shuffle_cards
     @cards.shuffle
    end
    
    def generate_deck
      @suits.each do |suit|
        @ranks.size.times do |i|
          # Ternary Operator
          color = (suit == 'Spades' || suit == 'Clubs') ? 'Black' : 'Red' 
          @cards << Card.new(@ranks[i], suit, color)
        end
      end
      random_card
    end

    def random_card
      rand_card = @cards.sample
      puts "Here is your card: #{rand_card.rank} #{rand_card.suit} (#{rand_card.color})"
    end
   
     def display_cards
       @cards.shuffle.each do |card|
         puts "#{card.rank} #{card.suit} (#{card.color})"
       end
     end
   end

  welcome
