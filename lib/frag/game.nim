import sdl2/sdl
import config, draw, input, module

type Game* = ref object of RootObj
  config*: Config
  draw*: Draw
  input*: Input
  modules*: seq[Module]

method init(this: Game) {.base.} = discard
method deinit(this: Game) {.base.} = discard
method update(this: Game) {.base.} = discard
method render(this: Game) {.base.} = discard

proc addModule(this: Game, module: Module): void =
  this.modules.add(module)

proc start*(this: Game) =
  this.draw = Draw(config: this.config)
  this.addModule(this.draw)
  this.input = Input()
  this.addModule(this.input)

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
  sdl.quit()
  system.quit()

proc run*(this: Game) =
  this.init()
  this.start()
