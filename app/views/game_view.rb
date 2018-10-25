class GameView

  def get_info(info)
    puts "#{info}"
    gets.chomp
  end


  def print_board(a)
      puts  "--------------------- "
      puts  "   #{a["1"]}  -   #{a["2"]}   -   #{a["3"]}      "
      puts  "--------------------- "
      puts  "   #{a["4"]}  -   #{a["5"]}   -   #{a["6"]}     "
      puts  "--------------------- "
      puts  "   #{a["7"]}  -   #{a["8"]}   -   #{a["9"]}      "
      puts  "--------------------- "
  end

end
