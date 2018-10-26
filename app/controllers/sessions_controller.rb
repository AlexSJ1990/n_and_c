class SessionsController
  def initialize
    @view = SessionView.new
  end

  def login
    username = @view.get_info("What is your username?")
    password = @view.get_info("What is your password?")

    # need to find instance of player where username and password match and return this player
    # need to implement active record first

  end
end
