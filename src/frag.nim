import sdl2/sdl

const
  title = "FRAG"
  width = 640
  height = 480
  windowFlags = 0
  rendererFlags = sdl.RendererAccelerated or sdl.RendererPresentVsync

type IGame = concept game
  init(game) or update(game) or render(game)
type Game = IGame

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

  return true

proc exit(app: App) =
  app.renderer.destroyRenderer()
  app.window.destroyWindow()
  sdl.quit()

proc run*[Game]() =
  var game: Game = Game()
  var app = App(window: nil, renderer: nil)

  if init(app):
    when compiles(game.init): game.init()

    while true:
      when compiles(game.update): game.update()

      sdlFailIf app.renderer.setRenderDrawColor(0x00, 0x00, 0x00, 0xff) != 0: "Failed to set draw color"
      sdlFailIf app.renderer.renderClear() != 0: "Failed to clear screen"

      when compiles(game.render): game.render()
      app.renderer.renderPresent()

  exit(app)

when isMainModule:
  type MyGame = ref object

  proc init(this: MyGame) = discard
  proc update(this: MyGame) = discard
  proc render(this: MyGame) = discard

  run[MyGame]()
