import module
import sdl2/sdl

var pressedKeys, releasedKeys: seq[sdl.Keycode]
var kbd = sdl.getKeyboardState(nil)

type Input* = ref object of Module

method init(this: Input) =
  pressedKeys = @[]
  releasedKeys = @[]

method update(this: Input) =
  var e: sdl.Event

  pressedKeys = @[]
  releasedKeys = @[]

  while sdl.pollEvent(addr(e)) != 0:
    case e.kind:
      of sdl.KeyDown: pressedKeys.add(e.key.keysym.sym)
      of sdl.KeyUp: releasedKeys.add(e.key.keysym.sym)
      # of sdl.Quit: game.quit()
      of sdl.Quit: echo "quit"
      else: discard

  kbd = sdl.getKeyboardState(nil)

proc down*(this: Input, button: string): bool =
  var key = sdl.getKeyFromName(button)
  var code = sdl.getScancodeFromKey(key)
  kbd[code] == 1

proc pressed*(this: Input, button: string): bool =
  sdl.getKeyFromName(button) in pressedKeys

proc released*(this: Input, button: string): bool =
  sdl.getKeyFromName(button) in releasedKeys
