import sdl2/sdl
import config

type Game* = ref object of RootObj
  window*: sdl.Window
  renderer*: sdl.Renderer

method init*(this: Game) {.base.} = discard
method update*(this: Game) {.base.} = discard
method render*(this: Game) {.base.} = discard

type SdlEx = object of Exception
template sdlFailIf(cond: typed, err: string) =
  if cond: raise SdlEx.newException(err & ", [SDL] error: " & $sdl.getError())

proc setupSdl(this: Game, cfg: Config): bool =
  sdlFailIf sdl.init(sdl.InitVideo) != 0: "Failed to initialize SDL"

  this.window = sdl.createWindow(
    cfg.title,
    min(cfg.pos.x, sdl.WindowPosUndefined),
    min(cfg.pos.y, sdl.WindowPosUndefined),
    cfg.width,
    cfg.height,
    uint32(cfg.windowFlags)
  )
  sdlFailIf this.window == nil: "Failed to create window"

  this.renderer = sdl.createRenderer(this.window, -1, uint32(cfg.rendererFlags))
  sdlFailIf this.renderer == nil: "Failed to create renderer"

  discard this.renderer.setRenderDrawBlendMode(sdl.BlendModeBlend)

  return true

proc start*(this: Game) =
  while true:
    this.update()

    sdlFailIf this.renderer.setRenderDrawColor(0x00, 0x00, 0x00, 0xff) != 0: "Failed to set draw color"
    sdlFailIf this.renderer.renderClear() != 0: "Failed to clear screen"

    this.render()
    this.renderer.renderPresent()

proc stop*(this: Game) =
  discard

proc quit*(this: Game) =
  this.renderer.destroyRenderer()
  this.window.destroyWindow()
  sdl.quit()
  system.quit()

proc run*(this: Game, cfg: Config) =
  if this.setupSdl(cfg):
    this.init()
    this.start()

  this.quit()
