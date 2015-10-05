class Game

  attr_accessor(:player1, :player2, :turn, :current_player, :idle_player)
  
  def initialize
    @player1 = nil
    @player2 = nil
    @turn = 1
    @current_player = nil
    @idle_player = nil
    @question = Question.new
  end
  
  def start_player1(nick_name)
    @player1 = Player.new(nick_name)
  end

  def start_player2(nick_name)
    @player2 = Player.new(nick_name)
  end

  def send_string_to_current(s)
    @current_client.puts s
  end

  def send_string_to_idle(s)
    @idle_client.puts s
  end
  
  def broadcast(s)
    @current_client.puts s
    @idle_client.puts s
  end
  
  def receive_input
      @current_client.gets.chomp.to_i
  end
  
  def receive_input_op
      @current_client.gets.chomp
  end

  def start
    set_current_player
    @question.get_first_number
  end
  
  def change_turn
    @turn == 1 ? @turn += 1 : @turn -=1
    set_current_player
  end 

  def display_current_player 
    send_string_to_current("IT'S YOUR TURN".bold)
    send_string_to_idle("#{@current_player.name}'S TURN".upcase.bold + " please wait...")
  end

  def set_current_player
    if @turn == 1
    @current_player = @player1
    @current_client = $client1
    @idle_player = @player2
    @idle_client = $client2
    else
    @current_player = @player2
    @current_client = $client2
    @idle_player = @player1
    @idle_client = $client1
    end
  end

  def damage
    if @turn == 1
      @player1.damage
      else
      @player2.damage
    end
    death_checker
  end

  def damage_self
    suicide_checker
  end

  def suicide_checker
    if @current_player.hp == 0
    @idle_player.kill_count
    end
    suicide_screen
  end

  def death_checker
    if @current_player.hp == 0
    @idle_player.kill_count
    death_screen
    end
  end

  def new_game
    @player1.hp = 1
    @player2.hp = 1
    @question.get_first_number
  end

  def question_screen
    broadcast("\e[H\e[2J")
    broadcast("#{@player1.name}  ".upcase.red.bold + "!!!!!!!VS.!!!!!!!".bg_brown.bold + "  #{@player2.name}".upcase.blue.bold)
    broadcast(" ") 
    broadcast(" ")
    broadcast("#{@player1.name}".upcase.bold + " killcount: #{@player1.kills}".red.bold)
    broadcast("#{@player2.name}".upcase.bold + " killcount: #{@player2.kills}".red.bold) 
    broadcast(" ")
    broadcast(" ")
    broadcast(" ")
    broadcast("Create and solve an equation to !KILL your opponent with.".bold)
    broadcast("Fail to solve your own equation and !KILL self.".red)
    broadcast("Solve your opponent's equation correctly to retaliate!".bold)
    broadcast(" ")
    broadcast(" ")
    broadcast(" ")
    broadcast(" ")
    broadcast(" ")
  end

  def death_screen
    broadcast("\e[H\e[2J")
    broadcast("#{@player1.name}  ".upcase.red.bold + "!!!!!!!VS.!!!!!!!".bg_brown.bold + "  #{@player2.name}".upcase.blue.bold)
    broadcast(" ") 
    broadcast(" ")
    broadcast("#{@player1.name}".upcase.bold + " killcount: #{@player1.kills}".red.bold)
    broadcast("#{@player2.name}".upcase.bold + " killcount: #{@player2.kills}".red.bold) 
    broadcast(" ")
    broadcast(" ")
    broadcast(" ")
    broadcast(" ")
    broadcast(" ")
    broadcast("!!!!WRONG!!!!!".bg_red.bold.reverse_color)
    broadcast("!!!!WRONG!!!!!".bg_red.bold.reverse_color)
    broadcast("#{@current_player.name}".upcase.bold.red + " DIES!!!".upcase.red)
    broadcast("!!!!WRONG!!!!!".bg_red.bold.reverse_color)
    broadcast("!!!!WRONG!!!!!".bg_red.bold.reverse_color)
    broadcast(" ")
    send_string_to_current("would you like to play again ? (Y/n/)")
      case receive_input_op
      when 'N' then abort
      else new_game
      end
  end

  def suicide_screen
    broadcast("\e[H\e[2J")
    broadcast("#{@player1.name}  ".upcase.red.bold + "!!!!!!!VS.!!!!!!!".bg_brown.bold + "  #{@player2.name}".upcase.blue.bold)
    broadcast(" ") 
    broadcast(" ")
    broadcast("#{@player1.name}".upcase.bold + " killcount: #{@player1.kills}".red.bold)
    broadcast("#{@player2.name}".upcase.bold + " killcount: #{@player2.kills}".red.bold) 
    broadcast(" ")
    broadcast(" ")
    broadcast(" ")
    broadcast(" ")
    broadcast(" ")
    broadcast("!!!!WRONG!!!!!".bg_red.bold.reverse_color)
    broadcast("!!!!WRONG!!!!!".bg_red.bold.reverse_color)
    broadcast("#{@current_player.name}".upcase.bold.red + " KILLS HIMSELF ?!?!?!".upcase.red)
    broadcast("!!!!WRONG!!!!!".bg_red.bold.reverse_color)
    broadcast("!!!!WRONG!!!!!".bg_red.bold.reverse_color)
    broadcast(" ")
    send_string_to_current("would you like to play again ? (Y/n/)")
      case receive_input_op
      when 'N' then abort
      else new_game
      end
  end
end
