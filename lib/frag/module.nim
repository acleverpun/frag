type Module* = ref object of RootObj

method init(this: Module) {.base.} = discard
method deinit(this: Module) {.base.} = discard
method update(this: Module) {.base.} = discard
method render(this: Module) {.base.} = discard
