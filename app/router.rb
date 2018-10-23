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


    print_welcome
  end
end
