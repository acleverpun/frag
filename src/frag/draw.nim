import basic2d
import game
import sdl2/sdl

proc color*(r, g, b: uint8 = 0, a: uint8 = 0xff): Color = Color(r: r, g: g, b: b, a: a)

proc drawPoint*(game: Game, pos: Vector2d, color: Color) =
  discard game.renderer.setRenderDrawColor(color)
  discard game.renderer.renderDrawPoint(pos.x.int, pos.y.int)

proc drawRect*(game: Game, rect: ptr Rect, color: Color) =
  discard game.renderer.setRenderDrawColor(color)
  discard game.renderer.renderDrawRect(rect)

proc fillRect*(game: Game, rect: ptr Rect, color: Color) =
  discard game.renderer.setRenderDrawColor(color)
  discard game.renderer.renderFillRect(rect)
