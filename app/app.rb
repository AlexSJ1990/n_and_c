require_relative 'models/game'
require_relative 'controllers/game_controller'
require_relative 'router'

controller = GameController.new

router = Router.new(controller)

router.run
