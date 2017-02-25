from colors import nil
import ../config, ../types/color, module
import basic2d
import sdl2/sdl except Color
import sdl2/sdl_gfx_primitives as gfx, sdl2/sdl_gfx_primitives_font as font

export color

type Draw* = ref object of Module
  config*: Config
  renderer: sdl.Renderer
  window: sdl.Window

type SdlEx = object of Exception
template sdlFailIf(cond: typed, err: string) =
  if cond: raise SdlEx.newException(err & ", [SDL] error: " & $sdl.getError())

proc setupSdl(this: Draw) =
  sdlFailIf sdl.init(sdl.InitVideo) != 0: "Failed to initialize SDL"

  this.window = sdl.createWindow(
    this.config.title,
    min(this.config.pos.x, sdl.WindowPosUndefined),
    min(this.config.pos.y, sdl.WindowPosUndefined),
    this.config.width,
    this.config.height,
    uint32(this.config.windowFlags)
  )
  sdlFailIf this.window == nil: "Failed to create window"

  this.renderer = sdl.createRenderer(this.window, -1, sdl.RendererAccelerated or sdl.RendererPresentVsync)
  sdlFailIf this.renderer == nil: "Failed to create renderer"

  discard this.renderer.setRenderDrawBlendMode(sdl.BlendModeBlend)

method init(this: Draw) =
  this.setupSdl()
  gfx.gfxPrimitivesSetFont(addr(font.gfxPrimitivesFontData), 8, 8)

method update(this: Draw) =
  sdlFailIf this.renderer.setRenderDrawColor(0x00, 0x00, 0x00, 0xff) != 0: "Failed to set draw color"
  sdlFailIf this.renderer.renderClear() != 0: "Failed to clear screen"

method render(this: Draw) =
  this.renderer.renderPresent()

method deinit(this: Draw) =
  this.renderer.destroyRenderer()
  this.window.destroyWindow()

proc drawPoint*(this: Draw, pos: Vector2d, color: Color) =
  discard this.renderer.setRenderDrawColor(color)
  discard this.renderer.renderDrawPoint(pos.x.int, pos.y.int)

proc drawRect*(this: Draw, rect: ptr Rect, color: Color) =
  discard this.renderer.setRenderDrawColor(color)
  discard this.renderer.renderDrawRect(rect)

proc fillRect*(this: Draw, rect: ptr Rect, color: Color) =
  discard this.renderer.setRenderDrawColor(color)
  discard this.renderer.renderFillRect(rect)

proc drawText*(this: Draw, text: string, point: Point2d, color: Color) =
  discard this.renderer.stringRGBA(point.x.int16, point.y.int16, text, color.r, color.g, color.b, color.a)
