import ../../lib/frag
import ./settings.nims
import basic2d
import sdl2/sdl

type Game = ref object of frag.Game

type
  Player = ref object
    width, height: float
    color: Color
    pos: Vector2d

proc getBounds(this: Player): Rect = Rect(x: this.pos.x.cint, y: this.pos.y.cint, w: this.width.cint, h: this.height.cint)

var p1, p2: Player
method init(this: Game) =
  frag.input.init(this)
  p1 = Player(width: 16, height: 100, color: "white", pos: vector2d(20, 20))
  p2 = Player(width: 16, height: 100, color: "white", pos: vector2d(400, 140))

method update(this: Game) =
  frag.input.update(this)

  if frag.input.down("q"): this.quit()

  if frag.input.down("k"): p1.pos.y -= 4
  if frag.input.down("j"): p1.pos.y += 4

  if frag.input.down("up"): p2.pos.y -= 4
  if frag.input.down("down"): p2.pos.y += 4

var rect1, rect2: Rect
method render(this: Game) =
  rect1 = p1.getBounds()
  rect2 = p2.getBounds()
  frag.draw.fillRect(this, addr(rect1), p1.color)
  frag.draw.fillRect(this, addr(rect2), p2.color)

frag.run[Game](cfg)
