require 'pry'
require 'colorize'
require 'artii'

@user_name = ''
@password = ''
@cchoice
# @account_balance = 0.00
n1 = rand(1...100)
n2 = rand(1...100)
@a = Artii::Base.new :font => 'slant'

@user_account = [
  {
    id: 1,
    name: "Christian",
    pass: '12',
    account_balance: 500.00
},
{
  id: 2,
  name: "Candice",
  pass: 'ab',
  account_balance: 1500.00
}
]

@win_loss_amount = 0

def welcome
  puts @a.asciify('DPL Casino!').colorize(:yellow)
  separator

  puts "Are you a returning user? (y/n)"
  separator
  @returning = gets.chomp
  case @returning
  when "y"
    returning_user
  when "n"
    new_user
  else
    puts "Please enter y or n"
  end
  
end

def new_user
  separator
  puts "Please enter your name"
  @user_name = gets.strip
  separator
  puts "Please enter your password"
  @password = gets.strip
  separator
  puts "Hello #{(@user_name).capitalize}, thank you for choosing DPL Casino!"
  separator
  lucky
end

def returning_user
  puts "Please enter your name:"
  get_username = gets.chomp
    @user_account.each do |user|
      if get_username == user[:name]
        puts "Please enter your password"
        get_pass = gets. chomp
        @user_account.each do |user|
          if get_pass == user[:pass]
            @user_name = get_username
            @password = get_pass
            @id = user[:id]
            @account_balance = user[:account_balance]
            puts "Welcome Back #{(@user_name).capitalize}"
            menu
          else
            next
          end
        end
        if @password == ''
          puts "Please enter a valid password".colorize(:red)
          returning_user
        end
      else
        next
      end
    end
    if @user_name == ''
      puts "Please enter a valid username".colorize(:red)
      returning_user
    end
end
    


def lucky
puts "Are you feeling lucky? y/n"
@lucky = gets.chomp
  if @lucky == "y"
    puts "...Spinning..."
    sleep(1)
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
    puts "4) View Win/Loss Amount"
    puts "5) Return to Main Menu"
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
        "Your win/loss amount so far is #{@win_loss_amount}"
        separator
        casino_account
      when 5
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

    new_id = @user_account.count + 1

    new_name = @user_name
    new_pass = @password
    new_account_balance = @account_balance

    if @returning == 'y'
      @user_account[@id - 1][:account_balance] = @account_balance
      # @user_account << update_hash
    elsif @returning == 'n'

        new_hash = {
          id: new_id,
          name: new_name,
          pass: new_pass,
          account_balance: new_account_balance
          }
        
          @user_account << new_hash
     end
    separator
    if @win_loss_amount > 0
      puts "You won #{@win_loss_amount}".colorize(:green)
    elsif @win_loss_amount < 0
      puts "Darn, looks like you lost #{@win_loss_amount}".colorize(:red)  
    else
      puts "Looks like you broke even."
    end
    separator
    puts "Thank you for visiting the DPL Casino!"
    puts "See You Soon!"
    exit
    
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
        @win_loss_amount -= @bet1
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
        @win_loss_amount += @bet1
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
    @myArray = ["rails", "class", "ruby", "goodies", "arrays" ]
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
       @win_loss_amount += @slot_bet
       puts "Your account balance is now $#{@account_balance}".colorize(:green)
       play_again
     elsif @item1 == @item2 || @item1 == @item3 || @item2 == @item3
       puts "2x Match! You Won!".colorize(:green)
       @slot_bet = @slot_bet / 2
       @account_balance += @slot_bet
       @win_loss_amount += @slot_bet
       puts "Your account balance is now $#{@account_balance}".colorize(:green)
       play_again
     else
       puts "0 Matches".colorize(:red)
       @account_balance -= @slot_bet
       @win_loss_amount -= @slot_bet
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
  #  @account_balance -= @bet
   
 def getroll
   2 + rand(1..6) + rand(1..6)
 end

#  init
 @roll1 = getroll
 puts "Your roll was " + @roll1.to_s
   if @roll1 == 7 || @roll1 == 11 || @roll1 == 12
     puts "You win!"
     @account_balance += @bet
     play_again_craps 
   elsif @roll1 == 2 || @roll1 == 3
      puts "Sorry, better luck next time!"
      @account_balance -= @bet
      play_again_craps 
    else
      puts "Try again"
      play_again_craps 
   end
 

  end

  welcome

