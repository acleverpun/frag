import frag/config, frag/game, frag/modules, frag/types
import sdl2/sdl

export config, game, modules, types

proc run*[Game](cfg: Config) =
  var game: Game = Game(config: cfg, modules: @[])
  game.run()
