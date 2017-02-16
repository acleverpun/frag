import sdl2/sdl

const
  title = "FRAG"
  width = 640
  height = 480
  windowFlags = 0
  rendererFlags = sdl.RendererAccelerated or sdl.RendererPresentVsync

type
  App = ref AppObj
  AppObj = object
    window*: sdl.Window
    renderer*: sdl.Renderer

type SdlEx = object of Exception
template sdlFailIf(cond: typed, err: string) =
  if cond: raise SdlEx.newException(err & ", SDL error: " & $sdl.getError())

proc init(app: App): bool =
  sdlFailIf sdl.init(sdl.InitVideo) != 0: "Can't initialize SDL"

  app.window = sdl.createWindow(
    title,
    sdl.WindowPosUndefined,
    sdl.WindowPosUndefined,
    width,
    height,
    windowFlags
  )
  sdlFailIf app.window == nil: "Can't create window"

  app.renderer = sdl.createRenderer(app.window, -1, rendererFlags)
  sdlFailIf app.renderer == nil: "Can't create renderer"

  sdlFailIf app.renderer.setRenderDrawColor(0xff, 0xff, 0xff, 0xff) != 0:
    "Can't set draw color"

  echo "SDL initialized successfully."
  return true

proc exit(app: App) =
  app.renderer.destroyRenderer()
  app.window.destroyWindow()
  sdl.quit()
  echo "SDL shutdown completed."

proc main() =
  var app = App(window: nil, renderer: nil)

  if init(app):
    sdlFailIf app.renderer.renderClear() != 0: "Can't clear screen"

    app.renderer.renderPresent()

    sdl.delay(1000)

  exit(app)

main()
