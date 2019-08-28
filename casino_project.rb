require 'colorize'
require 'artii'

@user_name
@cchoice
@account_balance = 0.00
n1 = rand(1...100)
n2 = rand(1...100)
@a = Artii::Base.new :font => 'slant'

@user_account = [
  {
    id: 1,
    name: "Christian Cuartas",
    pass: '123456',
    account_balance: 500.00
},
{
  id: 2,
  name: "Candice Cuartas",
  pass: 'abcdef',
  account_balance: 1500.00
}
]

@win_loss_amount = 0

def welcome
  puts @a.asciify('DPL Casino!').colorize(:yellow)
  separator
  puts "Please enter your name"
  @user_name = gets.strip
  separator
  puts "Hello #{(@user_name).capitalize}, thank you for choosing DPL Casino!"
  lucky
end

def new_user
  

end

def returning_user

end


def lucky
puts "Are you feeling lucky? y/n"
@lucky = gets.chomp
  if @lucky == "y"
    puts "...Spinning..."
    separator
    @account_balance = rand(1...1000).to_f
    @win_loss_amount = @account_balance
    puts "Congrats! $#{(@account_balance).round(2)} has been added to your account!".colorize(:green)
    separator
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
      if @account_balance > 0
      view_games
      separator
      else
        puts "You must deposit funds in your account before playing".colorize(:red)
        separator
        deposit
      end
    when 3
      exit_casino
    else
      separator
      puts "Please enter a valid choice".colorize(:red)
      separator
      menu
    end
  end

  def casino_account
    puts @a.asciify('Casino Account!')
    separator
    puts "Please select from the choices below"
    puts "1) View Account Balance"
    puts "2) Deposit Funds"
    puts "3) Withdraw Funds"
    puts "4) Return to Main Menu"
    @user_choice = gets.chomp.to_i
    case @user_choice
      when 1
        puts "Your Account Balance is #{@account_balance}".colorize(:green)
        separator
        casino_account
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
        puts "Please enter a valid choice".colorize.(:red)
        separator
        menu
      end
  
  end

  def view_games
    puts @a.asciify('Casino Games!')
    separator
    puts "Please choose a game below:"
    puts "1) Slots"
    puts "2) High/Low"
    puts "3) Craps"
    puts "4) Main Menu"
    @game_choice = gets.chomp.to_i

    if @game_choice == 1
      slots
    elsif @game_choice == 2
      high_low
    elsif @game_choice == 3
      craps
    elsif @game_choice == 4
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
    puts "Your Account Balance is #{@account_balance}".colorize(:green)
    puts "See You Soon!"
    Exit
  end

  def deposit
    puts 'Deposit Center'
    separator
    puts "How much would you like to deposit?"
    @deposit = gets.to_f
    @account_balance += @deposit
    separator
    puts "Your new balance is $#{@account_balance}".colorize(:green)
    menu
  end

  def withdraw
    puts "Withdrawal Center"
    separator
    puts "#{(@user_name).capitalize}, your balance is $#{@account_balance}".colorize(:green)
    puts "How much would you like to withdraw?"
    @withdraw = gets.chomp.to_f
      if @withdraw > @account_balance
        puts "Sorry, not enough funds".colorize(:red)
        separator
        withdraw
      elsif @withdraw <= @account_balance
        @account_balance -= @withdraw
        separator
        puts "Your remaining balance is $#{@account_balance}".colorize(:green)
        separator
        menu
      else
        puts "Please enter a valid amount".colorize(:red)
      end
  end

  def high_low
    n1 = rand(1...100)
    n2 = rand(1...100)
    puts @a.asciify('High / Low')
    separator
    puts "In this game you will get an initial number and then predict whether 
    the next number will be lower or higher than the first"
    puts "Your first number is #{n1}"
    separator
    puts "Please enter your bet amount:"
    puts "Your balance is currently: #{@account_balance}"
    @bet1 = gets.chomp.to_f
    separator
      while @bet1 > @account_balance do
        puts "Sorry, you cannot bet more than your balance".colorize(:red)
        puts "Please try another bet"
        @bet1 = gets.chomp.to_f
      end
      separator
    puts "Will the next number be higher or lower? (h/l)"
    @hl1 = gets.chomp
    separator
    puts "The next number is #{n2}"
    case @hl1
    when "h"
      if n2 > n1
        @bet1 *= 0.5
        @account_balance += @bet1
        @win_loss_amount += @bet1
        separator
          puts "Congratulations, you've won!".colorize(:green)
          
          puts "Your new balance is $#{@account_balance}".colorize(:green)
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
    
      elsif n2 < n1
        @account_balance -= @bet1
        puts "Sorry, you've lost".colorize(:red)
        puts "Your remaining balance is $#{@account_balance}"
        separator
        puts "Would you like to play again? y/n"
        @choice3 = gets.chomp
          case @choice3
            when "y"
              high_low
            when "n"
              menu
            else
            puts "Please enter y or n".colorize(:red)
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
            puts "Please enter y or n".colorize(:red)
          end
      end

    when "l"
      if n2 > n1
        @account_balance -= @bet1
        puts "Sorry, you've lost".colorize(:red)
        puts "Your remaining balance is $#{@account_balance}"
        separator
        puts "Would you like to play again? y/n"
        @choice3 = gets.chomp
          case @choice3
            when "y"
              high_low
            when "n"
              menu
            else
            puts "Please enter y or n".colorize(:red)
          end
    
      elsif n2 < n1
        @bet1 *= 0.5
        @account_balance += @bet1
          puts "Congratulations, you've won!".colorize(:green)
          puts "Your new balance is $#{@account_balance}".colorize(:green)
          separator
          puts "Would you like to play again? y/n"
          @choice2 = gets.chomp
            case @choice2
              when "y"
                high_low
              when "n"
                menu
              else
                puts "Please enter y or n".colorize(:red)
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
            puts "Please enter y or n".colorize(:red)
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
    puts @a.asciify('SLOTS')
    separator
    puts "In this game you will pull a lever and three random words will generate."
    puts "If all three match, you win! If 2 of the three match, you get a partial win!"
    separator
    puts "Your balance is currently: #{@account_balance}".colorize(:green)
    puts "How much would you like to bet?"
    @slot_bet = gets.strip.to_f
    separator
    while @slot_bet > @account_balance do
      puts "Sorry, you cannot bet more than your balance".colorize(:red)
      puts "Please try another bet"
      @slot_bet = gets.chomp.to_f
    end
    separator
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
     puts "[ #{@item1} ] [ #{@item2} ]  [ #{@item3} ]".colorize(:cyan)
   separator
     if @item1 == @item2 && @item1 == @item3 && @item2 == @item3
       puts "3x Match! You Won".colorize(:green)
       @account_balance += @slot_bet
       puts "Your account balance is now $#{@account_balance}".colorize(:green)
       play_again
     elsif @item1 == @item2 || @item1 == @item3 || @item2 == @item3
       puts "2x Match! You Won!".colorize(:green)
       @slot_bet = @slot_bet / 2
       @account_balance += @slot_bet
       puts "Your account balance is now $#{@account_balance}".colorize(:green)
       play_again
     else
       puts "0 Matches".colorize(:red)
       @account_balance -= @slot_bet
       puts "Your account balance is now $#{@account_balance}".colorize(:red)
       play_again
     end
   else
     puts "Press 'p' when you are ready to play"
   end
   end
   
   def play_again
     puts "Would you like to play again? (y/n)"
     @play_again = gets.strip
     if @play_again == "y"
       slots
     elsif @play_again == "n"
       menu
     else
       "Sorry that wasn't an option..".colorize(:red)
       play_again
     end
   end
   def play_again_craps
     puts "Would you like to play again? (y/n)"
     @play_again = gets.strip
     if @play_again == "y"
       craps
     elsif @play_again == "n"
       menu
     else
       "Sorry that wasn't an option..".colorize(:red)
       play_again_craps
     end
   end

def craps
  @a.asciify('Craps')   
   puts "Welcome to the game of Craps!"
   srand Time.now.tv_sec

   puts "Total cash: $#{@account_balance}"
   puts "How much would you like to bet?"
   @bet = gets.chomp.to_i
   @account_balance -= @bet
   
 def getroll
   2 + rand(6) + rand(6)
 end

#  init
 roll1 = getroll
 puts "Your roll was " + roll1.to_s
   case roll1
   when "7", "11", "12"
     puts "You win!"
       exit
   when "2", "3"
     puts "Sorry, better luck next time!"
       exit
   else
     puts "Roll again!"
   end
 
   point = getroll
   puts "Point is " + point.to_s
   case point
     when "7"
       puts "Sorry, better luck next time!"
     exit
     when roll1
       puts "You win!"
     exit
   end
    roll2 = "0"
     while point != roll2
     roll2 = getroll
     puts "Your roll is " + roll2.to_s
     case roll2
       when "7"
       puts "Sorry, better luck next time!"
     exit
       when point
       puts "You win!"
     exit
     else
       puts "Roll again"
     end
    end
    play_again_craps
  end

  welcome
