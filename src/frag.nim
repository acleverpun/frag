import frag/draw
import frag/game
import sdl2/sdl

export draw
export game

proc run*[Game](config: game.Config) =
  var game: Game = Game(window: nil, renderer: nil)
  game.run(config)
