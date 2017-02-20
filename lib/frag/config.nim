type Config* = ref object
  title*: string
  width*: int
  height*: int
  pos*: tuple[ x, y: int ]
  windowFlags*: int
  rendererFlags*: int
