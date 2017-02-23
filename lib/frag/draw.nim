from colors import nil
import basic2d
import draw/color, game, module
import sdl2/sdl except Color

export color

var window: sdl.Window
var renderer: sdl.Renderer

proc init*(game: Game) =
  echo "init"

proc deinit*(game: Game) =
  echo "deinit"

proc update*(game: Game) =
  echo "update"

proc render*(game: Game) =
  echo "render"

proc drawPoint*(game: Game, pos: Vector2d, color: Color) =
  discard game.renderer.setRenderDrawColor(color)
  discard game.renderer.renderDrawPoint(pos.x.int, pos.y.int)

proc drawRect*(game: Game, rect: ptr Rect, color: Color) =
  discard game.renderer.setRenderDrawColor(color)
  discard game.renderer.renderDrawRect(rect)

proc fillRect*(game: Game, rect: ptr Rect, color: Color) =
  discard game.renderer.setRenderDrawColor(color)
  discard game.renderer.renderFillRect(rect)
