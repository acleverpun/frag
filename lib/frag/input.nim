import game
import sdl2/sdl

var pressedKeys, releasedKeys: seq[sdl.Keycode]
var kbd = sdl.getKeyboardState(nil)

proc init*(game: Game) =
  pressedKeys = @[]
  releasedKeys = @[]

proc down*(button: string): bool =
  var key = sdl.getKeyFromName(button)
  var code = sdl.getScancodeFromKey(key)
  kbd[code] == 1

proc pressed*(button: string): bool =
  sdl.getKeyFromName(button) in pressedKeys

proc released*(button: string): bool =
  sdl.getKeyFromName(button) in releasedKeys

proc update*(game: Game) =
  var e: sdl.Event

  pressedKeys = @[]
  releasedKeys = @[]

  while sdl.pollEvent(addr(e)) != 0:
    case e.kind:
      of sdl.KeyDown: pressedKeys.add(e.key.keysym.sym)
      of sdl.KeyUp: releasedKeys.add(e.key.keysym.sym)
      of sdl.Quit: game.quit()
      else: discard

  kbd = sdl.getKeyboardState(nil)
