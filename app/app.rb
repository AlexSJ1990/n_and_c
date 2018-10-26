require_relative 'models/game'
require_relative 'controllers/games_controller'
require_relative 'router'

controller = GamesController.new

router = Router.new(controller)

router.run
