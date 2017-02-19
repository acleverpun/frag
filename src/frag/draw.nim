import colors
import basic2d
import game
import sdl2/sdl except Color

proc setColor(game: Game, color: Color, alpha: uint8 = 0xff) =
  var rgb = color.extractRGB()
  discard game.renderer.setRenderDrawColor(rgb.r, rgb.g, rgb.b, alpha)

proc drawPoint*(game: Game, pos: Vector2d, color: Color, alpha: uint8 = 0xff) =
  setColor(game, color, alpha)
  discard game.renderer.renderDrawPoint(pos.x.int, pos.y.int)

proc drawRect*(game: Game, rect: ptr Rect, color: Color, alpha: uint8 = 0xff) =
  setColor(game, color, alpha)
  discard game.renderer.renderDrawRect(rect)

proc fillRect*(game: Game, rect: ptr Rect, color: Color, alpha: uint8 = 0xff) =
  setColor(game, color, alpha)
  discard game.renderer.renderFillRect(rect)
