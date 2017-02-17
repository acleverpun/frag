import sdl2/sdl

const
  title = "FRAG"
  width = 640
  height = 480
  windowFlags = 0
  rendererFlags = sdl.RendererAccelerated or sdl.RendererPresentVsync

type IInit = concept game
  init(game)
type IUpdate = concept game
  update(game)
type IRender = concept game
  render(game)
type Game = IInit or IUpdate or IRender

type
  App = ref AppObj
  AppObj = object
    window*: sdl.Window
    renderer*: sdl.Renderer

type SdlEx = object of Exception
template sdlFailIf(cond: typed, err: string) =
  if cond: raise SdlEx.newException(err & ", [SDL] error: " & $sdl.getError())

proc init(app: App): bool =
  sdlFailIf sdl.init(sdl.InitVideo) != 0: "Failed to initialize SDL"

  app.window = sdl.createWindow(
    title,
    sdl.WindowPosUndefined,
    sdl.WindowPosUndefined,
    width,
    height,
    windowFlags
  )
  sdlFailIf app.window == nil: "Failed to create window"

  app.renderer = sdl.createRenderer(app.window, -1, rendererFlags)
  sdlFailIf app.renderer == nil: "Failed to create renderer"

  sdlFailIf app.renderer.setRenderDrawColor(0xff, 0xff, 0xff, 0xff) != 0:
    "Failed to set draw color"

  echo "SDL initialized successfully."
  return true

proc exit(app: App) =
  app.renderer.destroyRenderer()
  app.window.destroyWindow()
  sdl.quit()
  echo "SDL shutdown completed."

proc run*[Game]() =
  var game: Game = Game()
  var app = App(window: nil, renderer: nil)

  if init(app):
    sdlFailIf app.renderer.renderClear() != 0: "Failed to clear screen"
    app.renderer.renderPresent()
    game.init()

  exit(app)

when isMainModule:
  type MyGame = ref object

  proc init(this: MyGame) = echo "init!"
  proc update(this: MyGame) = echo "update!"
  proc render(this: MyGame) = echo "render!"

  run[MyGame]()
