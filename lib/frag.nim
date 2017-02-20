import frag/config
import frag/draw
import frag/game
import sdl2/sdl

export config
export draw
export game

proc run*[Game](cfg: Config) =
  var game: Game = Game(window: nil, renderer: nil)
  game.run(cfg)
