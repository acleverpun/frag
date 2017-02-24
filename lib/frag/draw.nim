from colors import nil
import basic2d
import draw/color, module, config
import sdl2/sdl except Color

export color

type Draw* = ref object of Module
  renderer*: sdl.Renderer

type SdlEx = object of Exception
template sdlFailIf(cond: typed, err: string) =
  if cond: raise SdlEx.newException(err & ", [SDL] error: " & $sdl.getError())

method init(this: Draw) =
  discard

method update(this: Draw) =
  sdlFailIf this.renderer.setRenderDrawColor(0x00, 0x00, 0x00, 0xff) != 0: "Failed to set draw color"
  sdlFailIf this.renderer.renderClear() != 0: "Failed to clear screen"
  this.renderer.renderPresent()

method render(this: Draw) =
  echo "render"

method deinit(this: Draw) =
  this.renderer.destroyRenderer()

proc drawPoint*(this: Draw, pos: Vector2d, color: Color) =
  discard this.renderer.setRenderDrawColor(color)
  discard this.renderer.renderDrawPoint(pos.x.int, pos.y.int)

proc drawRect*(this: Draw, rect: ptr Rect, color: Color) =
  discard this.renderer.setRenderDrawColor(color)
  discard this.renderer.renderDrawRect(rect)

proc fillRect*(this: Draw, rect: ptr Rect, color: Color) =
  discard this.renderer.setRenderDrawColor(color)
  discard this.renderer.renderFillRect(rect)
