from colors import nil
import basic2d
import draw/color
import game
import sdl2/sdl except Color

export color

proc drawPoint*(game: Game, pos: Vector2d, color: Color) =
  discard game.renderer.setRenderDrawColor(color)
  discard game.renderer.renderDrawPoint(pos.x.int, pos.y.int)

proc drawRect*(game: Game, rect: ptr Rect, color: Color) =
  discard game.renderer.setRenderDrawColor(color)
  discard game.renderer.renderDrawRect(rect)

proc fillRect*(game: Game, rect: ptr Rect, color: Color) =
  discard game.renderer.setRenderDrawColor(color)
  discard game.renderer.renderFillRect(rect)
