import sdl2/sdl
import game

export Game, quit, start, stop

proc run*[Game]() =
  var game: Game = Game(window: nil, renderer: nil)
  game.run()

when isMainModule:
  type MyGame = ref object of Game

  var i = 0
  method update(this: MyGame) =
    inc(i)
    if i == 50: this.quit()

  run[MyGame]()
