import sdl2/sdl
import config, module

type Game* = ref object of RootObj
  modules*: seq[Module]
  renderer*: sdl.Renderer
  window: sdl.Window

method init(this: Game) {.base.} = discard
method deinit(this: Game) {.base.} = discard
method update(this: Game) {.base.} = discard
method render(this: Game) {.base.} = discard

type SdlEx = object of Exception
template sdlFailIf(cond: typed, err: string) =
  if cond: raise SdlEx.newException(err & ", [SDL] error: " & $sdl.getError())

proc setupSdl(this: Game, cfg: Config) =
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

  this.renderer = sdl.createRenderer(this.window, -1, sdl.RendererAccelerated or sdl.RendererPresentVsync)
  sdlFailIf this.renderer == nil: "Failed to create renderer"

  discard this.renderer.setRenderDrawBlendMode(sdl.BlendModeBlend)

proc addModule*(this: Game, module: Module): void =
  this.modules.add(module)

proc start*(this: Game) =
  for module in this.modules: module.init()

  while true:
    this.update()
    for module in this.modules: module.update()
    this.render()
    for module in this.modules: module.render()

proc stop*(this: Game) =
  discard

proc quit*(this: Game) =
  this.deinit()
  this.window.destroyWindow()
  sdl.quit()
  system.quit()

proc run*(this: Game, cfg: Config) =
  this.setupSdl(cfg)
  this.init()
  this.start()

  this.quit()
