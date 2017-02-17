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

type Game* = ref object of RootObj
  app: App
  isRunning: bool

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

proc exit*(game: Game) =
  game.app.renderer.destroyRenderer()
  game.app.window.destroyWindow()
  sdl.quit()
  system.quit()

proc run*[Game]() =
  var game: Game = Game(app: nil)
  var app = App(window: nil, renderer: nil)
  game.app = app
  game.isRunning = true

  if init(app):
    when compiles(game.init): game.init()

    while game.isRunning == true:
      when compiles(game.update): game.update()

      sdlFailIf app.renderer.setRenderDrawColor(0x00, 0x00, 0x00, 0xff) != 0: "Failed to set draw color"
      sdlFailIf app.renderer.renderClear() != 0: "Failed to clear screen"

      when compiles(game.render): game.render()
      app.renderer.renderPresent()

  game.exit()

when isMainModule:
  type MyGame = ref object of Game

  proc init(this: MyGame) = discard

  var i = 0
  proc update(this: MyGame) =
    inc(i)
    if i == 50: this.exit()

  proc render(this: MyGame) = discard

  run[MyGame]()
