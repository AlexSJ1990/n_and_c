
class Game
  attr_reader :player, :result, :move

  def initialize(attributes = {})
    @id = attributes[:id]
    @player = attributes[:player]
    @result = attributes[:result]
    @move = attributes[:move]
    @game_over = false
  end

  def game_over!
    @game_over = true
  end
end



# next steps

# call Game.game_over! method from controller

# need to implement a sessions controller to handle login and return player

# need to implement database with Active Record


