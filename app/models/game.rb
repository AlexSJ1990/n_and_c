
class Game
  attr_reader :player, :result, :move

  def initialize(attributes = {})
    @id = attributes[:id]
    @player = attributes[:player]
    @result = attributes[:result]
    @move = attributes[:move]
  end

end

