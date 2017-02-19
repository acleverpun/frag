from sdl2/sdl import RendererAccelerated, RendererPresentVsync
import ../../lib/frag/game

var config*: Config = (
  title: "FRAG",
  width: 640,
  height: 480,
  windowFlags: 0,
  rendererFlags: sdl.RendererAccelerated or sdl.RendererPresentVsync
)
