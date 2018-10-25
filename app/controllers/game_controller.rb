require_relative '../views/game_view'

class GameController
  # POSITIONS = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  POSITIONS = {
    "1" => "1",
    "2" => "2",
    "3" => "3",
    "4" => "4",
    "5" => "5",
    "6" => "6",
    "7" => "7",
    "8" => "8",
    "9" => "9"
  }

  def initialize
    @view = GameView.new
  end

  def play
    mark_position
    check_if_game_over
  end

  def mark_position
    @view.print_board(POSITIONS)
    position_to_play = @view.get_info("Which position do you want to play?")
    if POSITIONS.keys.include?(position_to_play)

      # in here need a ternary if player not compter ?  x : o

      POSITIONS["#{position_to_play}"] = "x"
    end
    @view.print_board(POSITIONS)
  end

  def check_if_game_over
    # if positions hash keys include
    # if positions[1] positions[5] positions[9] == "x, x, x"
      p [POSITIONS["1"], POSITIONS["5"], POSITIONS["9"]]
    if [POSITIONS["1"], POSITIONS["5"], POSITIONS["9"]] == ["x", "x", "x"]

    else
      mark_position
    end
  end
end
