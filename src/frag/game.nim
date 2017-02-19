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

const
  title = "FRAG"
  width = 640
  height = 480
  windowFlags = 0
  rendererFlags = sdl.RendererAccelerated or sdl.RendererPresentVsync

proc setupSdl(this: Game): bool =
  sdlFailIf sdl.init(sdl.InitVideo) != 0: "Failed to initialize SDL"

  this.window = sdl.createWindow(
    title,
    sdl.WindowPosUndefined,
    sdl.WindowPosUndefined,
    width,
    height,
    windowFlags
  )
  sdlFailIf this.window == nil: "Failed to create window"

  this.renderer = sdl.createRenderer(this.window, -1, rendererFlags)
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

proc run*(this: Game) =
  if this.setupSdl():
    this.init()
    this.start()

  this.quit()
