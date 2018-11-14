
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

  OPPOSITE_CORNERS_FOR_SIDES = {
    "2" => ["7", "9"],
    "4" => ["3", "9"],
    "6" => ["1", "7"],
    "8" => ["1", "3"]
  }

  OPPOSITE_CORNERS_FOR_CORNER = {
    "1" => "9",
    "9" => "1",
    "3" => "7",
    "7" => "3"
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
    @current_player == "computer" ? computer_play_first_center : mark_position
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
        player.values & ["1", "4", "7"] == ["1", "4", "7"] ||
        player.values & ["1", "2", "3"] == ["1", "2", "3"] ||
        player.values & ["3", "5", "7"] == ["3", "5", "7"] ||
        player.values & ["3", "6", "9"] == ["3", "6", "9"] ||
        player.values & ["2", "5", "8"] == ["2", "5", "8"] ||
        player.values & ["7", "8", "9"] == ["7", "8", "9"] ||
        player.values & ["4", "5", "6"] == ["4", "5", "6"]
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
    # @players = ["human", "computer"]
    @players = ["computer", "computer"] # remember to change this back to human or computer !!
    @players.sample
  end


  # if computer goes first we always want to play in the centre first
  # need a strategy for if human_player plays an edge piece or a corner piece

  # round 0 - computer plays centre
  # round 1 - if human_player plays edge computer plays
  # round 1 - if human_player plays corner computer plays opposite corner ??

  def computer_play_first_center
    if @starter_player == "computer" # can delete this line??
      p @round
      if @round == 0            # round 0 - computer plays centre
        POSITIONS["5"] = "[]"
        COMPUTER_MOVES["ROUND_0"] = "5"
      elsif @round == 1         # round 1 - computer move dependent on human_player move in round 0
        CORNER_POSITIONS.each do |position|
          if POSITIONS[position] == "x"
            POSITIONS[OPPOSITE_CORNERS_FOR_CORNER[position]] = "[]"
            COMPUTER_MOVES["ROUND_1"] = OPPOSITE_CORNERS_FOR_CORNER[position]
            CORNER_POSITIONS.delete(position)
          else
            # human_player has put their first piece on a side
            SIDE_POSITIONS.each do |position|
                p POSITIONS[position] == "x"
              if POSITIONS[position] == "x"         # play postion on either opposite corner
                position_chosen = OPPOSITE_CORNERS_FOR_SIDES[position].sample
                POSITIONS[position_chosen] = "[]"
                COMPUTER_MOVES["ROUND_1"] = position_chosen
                # TODO: remember why we delete this..
                SIDE_POSITIONS.delete(position)
              end
            end
          end
        end
      elsif @round == 2
      # TODO: check_if_win_close # if they have 2 of 3 then will need to block else go with offensive strategy
      # check if either diagonals are equal to zero (this means that they are filled with noughts or crosses)
      # if the below condition is true it also means that they have selected a corner position
      # issue is still here !!

        if ["1", "3", "7", "9"].include?(HUMAN_MOVES["ROUND_0"])
            # we already know that the moves so far create a diagonal on the board
            # if the human_players next move is a side position (a mistake) then we set a trap via a triangle
            # need to check if the side position is next to their initial position or not as this will change the triangle created
          if HUMAN_MOVES["ROUND_0"] == "1"
            HUMAN_MOVES["ROUND_1"] == "2" || HUMAN_MOVES["ROUND_1"] == "8" ? POSITIONS["3"] = "[]" : POSITIONS["7"] = "[]"
          elsif HUMAN_MOVES["ROUND_0"] == "9"
            HUMAN_MOVES["ROUND_1"] == "2" || HUMAN_MOVES["ROUND_1"] == "8" ? POSITIONS["7"] = "[]" : POSITIONS["3"] = "[]"
          end
        else    # this else means that the human_player has selected a side position for round 0
          # below will need to be refactored for if human player doesnt block - then you should go for the win
          # actually this can go in the different check_win function?
          case
            when HUMAN_MOVES["ROUND_0"] == "2" && HUMAN_MOVES["ROUND_1"] == "1" && COMPUTER_MOVES["ROUND_1"] == "9" then POSITIONS["3"] = "[]"
            when HUMAN_MOVES["ROUND_0"] == "2" && HUMAN_MOVES["ROUND_1"] == "3" && COMPUTER_MOVES["ROUND_1"] == "7" then POSITIONS["1"] = "[]"
            when HUMAN_MOVES["ROUND_0"] == "4" && HUMAN_MOVES["ROUND_1"] == "1" then POSITIONS["3"] = "[]"
            when HUMAN_MOVES["ROUND_0"] == "6" && HUMAN_MOVES["ROUND_1"] == "1" then POSITIONS["3"] = "[]"
            when HUMAN_MOVES["ROUND_0"] == "8" && HUMAN_MOVES["ROUND_1"] == "1" then POSITIONS["3"] = "[]"
          end
        end
      elsif @round == 3
        check_if_win_close

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
    # this method will be called on computers go
    # first want to check human moves

    players = [HUMAN_MOVES, COMPUTER_MOVES]
    players.each do |player|
      if player.values & ["1", "5", "9"] == ["1", "5"] ||
        player.values & ["1", "4", "7"] == ["1", "4", "7"] ||
        player.values & ["1", "2", "3"] == ["1", "2", "3"] ||
        player.values & ["3", "5", "7"] == ["3", "5", "7"] ||
        player.values & ["3", "6", "9"] == ["3", "6", "9"] ||
        player.values & ["2", "5", "8"] == ["2", "5", "8"] ||
        player.values & ["7", "8", "9"] == ["7", "8", "9"] ||
        player.values & ["4", "5", "6"] == ["4", "5", "6"]



        winning_combinations.each do |combination|
        # create new hash with

        end
      end
    end
  end

  def computer_play
    # if value is "x" or "[]" when you convert to integer becomes 0
    position = @positions_left.sample
    POSITIONS[position] = "[]"
  end

end
