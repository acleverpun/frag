import frag/config, frag/draw, frag/game, frag/geom
import sdl2/sdl

export config, draw, game, geom

proc run*[Game](cfg: Config) =
  var game: Game = Game(window: nil, renderer: nil)
  game.run(cfg)
