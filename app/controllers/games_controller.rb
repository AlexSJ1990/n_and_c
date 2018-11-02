
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

  HUMAN_MOVES = {
    "ROUND_0" => 0,
    "ROUND_1" => 0,
    "ROUND_2" => 0,
    "ROUND_3" => 0,
    "ROUND_4" => 0
  }

  COMPUTER_MOVES = {
    "ROUND_0" => 0,
    "ROUND_1" => 0,
    "ROUND_2" => 0,
    "ROUND_3" => 0,
    "ROUND_4" => 0
  }

  CORNER_POSITIONS = [POSITIONS["1"], POSITIONS["3"], POSITIONS["7"], POSITIONS["9"]]
  SIDE_POSITIONS = POSITIONS.values.select { |position| position if position.to_i.even? }

  def initialize
    @view = GameView.new
    @round = 0
  end

  def play
    @starter_player = who_starts
    p @starter_player
    @current_player = @starter_player
    until @game_over == true
      which_round
      whose_move      # calls the whose_move method returning computer or human to play move
      @alternate_player = @players.select { |player| player != @current_player }.first
      check_if_game_over
      @current_player = @alternate_player
    end
  end



  private

  def which_round
    @positions_left = POSITIONS.values.select { |value| value if value.to_i != 0 }
    p "positions left is #{@positions_left.length}"
    if @positions_left.length == 9 || @positions_left.length == 8
      @round = 0
    elsif @positions_left.length == 7 || @positions_left.length == 6
      @round = 1
    elsif @positions_left.length == 5 || @positions_left.length == 4
      @round = 2
    elsif @positions_left.length == 3 || @positions_left.length == 2
      @round = 3
    elsif @positions_left.length == 1 || @positions_left.length == 0
      @round = 4
    end
  end

  def whose_move
    @current_player == "computer" ? computer_play : mark_position
  end

  def mark_position
    @view.print_board(POSITIONS)
    p "round is #{@round.to_s}"
    position_to_play = @view.get_info("Which position do you want to play?")
    if POSITIONS.keys.include?(position_to_play)
      POSITIONS["#{position_to_play}"] = "x"
      HUMAN_MOVES["ROUND_#{@round}"] = position_to_play
    end
  end

  def check_if_game_over
    players = [HUMAN_MOVES, COMPUTER_MOVES]
    players.each do |player|
      if player.values & ["1", "5", "9"] == ["1", "5", "9"] ||
        (player.values & ["1", "4", "7"] == ["1", "4", "7"]) ||
        (player.values & ["1", "2", "3"] == ["1", "2", "3"]) ||
        (player.values & ["3", "5", "7"] == ["3", "5", "7"]) ||
        (player.values & ["3", "6", "9"] == ["3", "6", "9"]) ||
        (player.values & ["2", "5", "8"] == ["2", "5", "8"]) ||
        (player.values & ["7", "8", "9"] == ["7", "8", "9"]) ||
        (player.values & ["4", "5", "6"] == ["4", "5", "6"])
        @game_over = true
        @view.print_info("Game Over: Winner is #{@current_player}")
        @view.print_board(POSITIONS)
      elsif @positions_left.length == 0
        @game_over = true
        @view.print_info("Game Over: Tie")
        @view.print_board(POSITIONS)
      end
    end
  end

  def who_starts
    @players = ["human", "computer"]
    @players.sample
  end

  def computer_play_first_center
    if @starter_player == "computer" # can delete this line??
      p @round
      if @round == 0            # if we are starting the first round - select middle position
        POSITIONS["5"] = "[]"
      elsif @round == 1         # if human player has selected a corner position then ...
        CORNER_POSITIONS.each do |position|
          if POSITIONS[position] == "x"
            p "position is #{position}"
            if position == "1"
              POSITIONS["9"] = "[]"
            elsif position == "9"
              POSITIONS["1"] = "[]"
            elsif position == "3"
              POSITIONS["7"] == "[]"
            elsif position == "7"
              POSITIONS["3"] = "[]"
            end
          else
          #   SIDE_POSITIONS.each do |position|
          #     if POSITIONS[position] == "x"
          #       if position == "2"


          #   # POSITIONS
          end
        end
      # elsif @round == 2
      #   check_if_win_close # if they have 2 of 3 then will need to block else go with offensive strategy
      end
    end
  end

  def move_position(position)
    if @current_player == "computer"
      POSITIONS[position.to_s] == "[]"
    else
      POSITIONS[position.to_s] == "x"
    end
  end

  def computer_play_second
    if POSITIONS["5"] == "x"
      move_position = ["1", "3", "7", "9"].sample
      POSITIONS[move_position] = "[]"
    end
  end

  def check_if_win_close
    # TODO
    # want this to work both ways if computer has 2 in a row play the 3rd
    # if the human has 2 in a row want to block the 3rd
  end

  def computer_play
    # if value is "x" or "[]" when you convert to integer becomes 0
    position = @positions_left.sample
    POSITIONS[position] = "[]"
  end

end
