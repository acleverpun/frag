import game
import sdl2/sdl

var keys: seq[sdl.Keycode]
var kbd = sdl.getKeyboardState(nil)

proc init*(game: Game) =
  keys = @[]

proc down*(button: string): bool =
  var key = sdl.getKeyFromName(button)
  var code = sdl.getScancodeFromKey(key)
  kbd[code] == 1

proc pressed*(button: string): bool =
  sdl.getKeyFromName(button) in keys

proc released*(button: string): bool = discard

proc update*(game: Game) =
  var e: sdl.Event

  if keys != nil: keys = @[]

  while sdl.pollEvent(addr(e)) != 0:
    case e.kind:
      of sdl.KeyDown:
        if keys != nil: keys.add(e.key.keysym.sym)
      of sdl.Quit:
        game.quit()
      else: discard

  kbd = sdl.getKeyboardState(nil)
