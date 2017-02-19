import sdl2/sdl

type Game* = ref object of RootObj
  window*: sdl.Window
  renderer*: sdl.Renderer

method init*(this: Game) {.base.} = discard
method update*(this: Game) {.base.} = discard
method render*(this: Game) {.base.} = discard

type SdlEx = object of Exception
template sdlFailIf(cond: typed, err: string) =
  if cond: raise SdlEx.newException(err & ", [SDL] error: " & $sdl.getError())

type Config* = tuple[
  title: string,
  width: int,
  height: int,
  # pos: tuple[ x, y: int ],
  windowFlags: int,
  rendererFlags: int
]

proc setupSdl(this: Game, config: Config): bool =
  sdlFailIf sdl.init(sdl.InitVideo) != 0: "Failed to initialize SDL"

  this.window = sdl.createWindow(
    config.title,
    # config.pos.x or sdl.WindowPosUndefined,
    # config.pos.y or sdl.WindowPosUndefined,
    sdl.WindowPosUndefined,
    sdl.WindowPosUndefined,
    config.width,
    config.height,
    uint32(config.windowFlags)
  )
  sdlFailIf this.window == nil: "Failed to create window"

  this.renderer = sdl.createRenderer(this.window, -1, uint32(config.rendererFlags))
  sdlFailIf this.renderer == nil: "Failed to create renderer"

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

proc run*(this: Game, config: Config) =
  if this.setupSdl(config):
    this.init()
    this.start()

  this.quit()
