require_relative '../views/game_view'

class GameController
  def initialize
    @view = GameView.new
  end

  def play
    mark_position
  end

  def mark_position
    positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    position_to_play = @view.get_info("Which position do you want to play?")
    # if position to play is included in array - remove position from array

    # if positions.include?(position_to_play)
    #   positions.delete_at(position_to_play - 1)
    #   p positions
    # end
    p positions
  end

  def check_if_game_over

  end

end
