import basic2d
import game
import sdl2/sdl
from colors import nil

export Color

type rgb* = tuple[ r, g, b: uint8 ]
type rgbi* = tuple[ r, g, b: int ]
type rgba* = tuple[ r, g, b, a: uint8 ]
type rgbai* = tuple[ r, g, b, a: int ]

# handle channels
converter toUint8(val: int): uint8 = val.uint8
proc color*(r, g, b: uint8 = 0, a: uint8 = 0xff): Color = Color(r: r, g: g, b: b, a: a)

# handle tuples
proc color*(val: rgb): Color = color(val.r, val.g, val.b)
proc color*(val: rgbi): Color = color(val.r, val.g, val.b)
proc color*(val: rgba): Color = color(val.r, val.g, val.b, val.a)
proc color*(val: rgbai): Color = color(val.r, val.g, val.b, val.a)

# handle colors module
proc color*(val: colors.Color): Color = color(colors.extractRGB(val))
proc color*(val: string): Color = color(colors.parseColor(val))
proc color*(val: int): Color = color(colors.Color(val))

converter toColor*(val: string): Color = color(val)
converter toColor*(val: rgb): Color = color(val)
converter toColor*(val: rgbi): Color = color(val)
converter toColor*(val: rgba): Color = color(val)
converter toColor*(val: rgbai): Color = color(val)

proc drawPoint*(game: Game, pos: Vector2d, color: Color) =
  discard game.renderer.setRenderDrawColor(color)
  discard game.renderer.renderDrawPoint(pos.x.int, pos.y.int)

proc drawRect*(game: Game, rect: ptr Rect, color: Color) =
  discard game.renderer.setRenderDrawColor(color)
  discard game.renderer.renderDrawRect(rect)

proc fillRect*(game: Game, rect: ptr Rect, color: Color) =
  discard game.renderer.setRenderDrawColor(color)
  discard game.renderer.renderFillRect(rect)
