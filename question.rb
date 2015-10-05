

class Question
  attr_accessor(:num1, :op, :num2, :user_solution)
  
  def initialize
    @num1 = nil
    @num2 = nil
    @op = nil
    @user_solution = nil
  end
  


  def get_first_number
    $game.question_screen
    $game.display_current_player
    $game.send_string_to_current("(awaiting input...)".bold + " (?) ( ... ) = ( ... )")
    $game.send_string_to_idle("[----->25%                ] preparing equation")
    @num1=$game.receive_input
    get_operator
  end

  def get_operator
    $game.question_screen
    $game.display_current_player
    $game.send_string_to_current("#{@num1} (insert operator...)".bold + " ( ... ) = ( ... )")
    $game.send_string_to_idle("[---------->50%           ] preparing equation")
    @op=$game.receive_input_op
    get_second_number
  end

  def get_second_number
    $game.question_screen
    $game.display_current_player
    $game.send_string_to_current("#{@num1} #{@op} (awaiting input...)".bold + " = (-)")
    $game.send_string_to_idle("[--------------->75%      ] preparing equation")
    @num2= $game.receive_input
    get_user_solution
  end

  def get_user_solution
    $game.question_screen
    $game.display_current_player
    $game.send_string_to_current("#{@num1} #{@op} #{@num2} = ".bold + "(awaiting solution...)".bold)
    $game.send_string_to_idle("[-------------------->100%] equation incoming...".green)
    @user_solution=$game.receive_input
    check_user_solution
  end

  def send_equation
    $game.question_screen
    $game.display_current_player
    $game.send_string_to_idle("Opponent is solving equation...")
    $game.send_string_to_current("#{@num1} #{@op} #{@num2} = ".bold + "(awaiting input...)".bold)
    @user_solution=$game.receive_input
    check_opponent_solution
  end
  
  def check_opponent_solution
    $game.question_screen
    $game.display_current_player
    if @user_solution == @solution
      $game.broadcast("!!!!CORRECT!!!!!".bg_blue.bold.reverse_color)
      $game.send_string_to_current("Press ENTER to create new equation".bold)
      $game.receive_input
      get_first_number
    else
      $game.damage
    end
  end
  
  def check_user_solution
    $game.question_screen
    $game.display_current_player
    case @op
      when '+' then @solution = @num1 + @num2
      when '-' then @solution = @num1 - @num2
      when '*' then @solution = @num1 * @num2
      when '/' then @solution = @num1 / @num2
    end
    if @user_solution == @solution
      $game.send_string_to_current("!!!!CORRECT!!!!!".bg_blue.bold.reverse_color)
      $game.send_string_to_current("Press ENTER to send attack !!!".bold)
      $game.send_string_to_idle("[-------------------->100%] equation incoming...".bold.green)
      $game.receive_input
      $game.change_turn
      send_equation
    else
      $game.damage_self
    end
  end


end