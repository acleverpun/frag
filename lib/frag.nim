import frag/config, frag/draw, frag/game, frag/geom, frag/input
import sdl2/sdl

export config, draw, game, geom, input

proc run*[Game](cfg: Config) =
  var game: Game = Game(modules: @[])
  game.run(cfg)
