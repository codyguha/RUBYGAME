class DisplayElements

  attr_accessor
  
  def initialize

  end

  def question_screen
    $game.broadcast("\e[H\e[2J")
    $game.broadcast("#{@player1.name}  ".upcase.red.bold + "!!!!!!!VS.!!!!!!!".bg_brown.bold + "  #{@player2.name}".upcase.blue.bold)
    $game.broadcast() 
    $game.broadcast() 
    $game.broadcast("Create and solve an equation to attack your opponent, #{@idle_player.name.upcase}".bold)
    $game.broadcast( "Fail to solve the equation correctly and attack yourself".bold.red)
    $game.broadcast()
    $game.broadcast("#{@current_player.name}'s Equation".capitalize)
  end

  def solve_screen
    $game.broadcast("\e[H\e[2J")
    $game.broadcast("#{@player1.name}  ".upcase.red.bold + "!!!!!!!VS.!!!!!!!".bg_brown.bold + "  #{@player2.name}".upcase.blue.bold)
    $game.broadcast() 
    $game.broadcast() 
  end


end