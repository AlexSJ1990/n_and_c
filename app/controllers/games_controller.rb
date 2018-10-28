
require_relative '../views/game_view'

class GamesController

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
    @starter_player = who_starts
    @starter_player == "human" ? mark_position : computer_play_first_move
    check_if_game_over

    until @game_over == true
      if @starter_player == "human"
        computer_play
        break if check_if_game_over
        mark_position
        break if check_if_game_over
      else
        mark_position
        break if check_if_game_over
        computer_play
        break if check_if_game_over
      end
    end
  end



  private

  def mark_position
    @view.print_board(POSITIONS)
    position_to_play = @view.get_info("Which position do you want to play?")
    if POSITIONS.keys.include?(position_to_play)
      POSITIONS["#{position_to_play}"] = "x"
    end
  end

  def check_if_game_over
    x = ["x", "x", "x"]
    o = ["[]", "[]", "[]"]
    if ([POSITIONS["1"], POSITIONS["5"], POSITIONS["9"]] == x || [POSITIONS["1"], POSITIONS["5"], POSITIONS["9"]] == o) ||
      ([POSITIONS["1"], POSITIONS["4"], POSITIONS["7"]] == x || [POSITIONS["1"], POSITIONS["4"], POSITIONS["7"]] == o) ||
      ([POSITIONS["1"], POSITIONS["2"], POSITIONS["3"]] == x || [POSITIONS["1"], POSITIONS["2"], POSITIONS["3"]] == o) ||
      ([POSITIONS["3"], POSITIONS["5"], POSITIONS["7"]] == x || [POSITIONS["3"], POSITIONS["5"], POSITIONS["7"]] == o) ||
      ([POSITIONS["3"], POSITIONS["6"], POSITIONS["9"]] == x || [POSITIONS["3"], POSITIONS["6"], POSITIONS["9"]] == o) ||
      ([POSITIONS["2"], POSITIONS["5"], POSITIONS["8"]] == x || [POSITIONS["2"], POSITIONS["5"], POSITIONS["8"]] == o) ||
      ([POSITIONS["7"], POSITIONS["8"], POSITIONS["9"]] == x || [POSITIONS["7"], POSITIONS["8"], POSITIONS["9"]] == o) ||
      ([POSITIONS["4"], POSITIONS["5"], POSITIONS["6"]] == x || [POSITIONS["4"], POSITIONS["5"], POSITIONS["6"]] == o)
      @game_over = true
      p "Game Over: Winner is "
      @view.print_board(POSITIONS)
    end
  end

  def who_starts
    players = ["human", "computer"]
    p start = players.sample
  end

  def computer_play_first_move
    # @view.print_board(POSITIONS)
    if @starter_player == "computer"
      start_position = ["1", "3", "5", "7", "9"].sample
      POSITIONS[start_position] = "[]"
    elsif @starter_player == "human"
      if POSITIONS[5] == "x"
        move_position = ["1", "3", "7", "9"].sample
        POSITIONS[move_position] = "[]"
      end
    end
  end

  def computer_play
    positions_left = []
    # if value is "x" or "[]" when you convert to integer becomes 0
    POSITIONS.values.each { |value| positions_left << value if value.to_i != 0 }
    position = positions_left.sample
    POSITIONS[position] = "[]"
  end

end
