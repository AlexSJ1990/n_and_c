class Router
  def initialize(controller)
    @controller = controller
  end

  def run

    def print_welcome
      puts "Welcome to Naughts and Crosses"
      puts  "--------------------- "
      puts  "   X  -       -         "
      puts  "--------------------- "
      puts  "      -   O   -        "
      puts  "--------------------- "
      puts  "      -       -   X      "
      puts  "--------------------- "
    end

    def choice
      puts "What would you like to do next?"
      puts "1 - Play another game"
    end

    def route_action(action)
      case action
      when 1 then @controller.play
      end
    end


    print_welcome
    choice
    action = gets.chomp.to_i
    route_action(action)
  end
end
