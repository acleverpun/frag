import ../../lib/frag
import ./settings.nims
import basic2d

type
  Game = ref object of frag.Game
  Player = ref object
    width, height: float
    color: Color
    pos: Point2d
  Ball = ref object
    radius: float
    color: Color
    pos: Point2d

proc getBounds(this: Player): Rect = Rect(x: this.pos.x.cint, y: this.pos.y.cint, w: this.width.cint, h: this.height.cint)

var p1, p2: Player
method init(this: Game) =
  p1 = Player(width: 16, height: 100, color: "white", pos: point2d(20, 20))
  p2 = Player(width: 16, height: 100, color: "white", pos: point2d(400, 140))

method update(this: Game) =
  if this.input.pressed("q"): this.quit()

  if this.input.down("k"): p1.pos.y -= 4
  if this.input.down("j"): p1.pos.y += 4

  if this.input.down("up"): p2.pos.y -= 4
  if this.input.down("down"): p2.pos.y += 4

var rect1, rect2: Rect
method render(this: Game) =
  this.draw.drawText("GNOP", Point2d(x: 300, y: 20), "red")
  rect1 = p1.getBounds()
  rect2 = p2.getBounds()
  this.draw.fillRect(addr(rect1), p1.color)
  this.draw.fillRect(addr(rect2), p2.color)

frag.run[Game](settings.cfg)
