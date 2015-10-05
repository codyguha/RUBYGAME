class Player
  attr_accessor(:name, :hp, :kills)
  
  def initialize(name)
    @name = name
    @hp = 1
    @kills = 0
  end
  
  def kill_count
    @kills += 1
  end
  
  def damage
    @hp -= 1
  end
end