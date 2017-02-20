import ../../lib/frag
import basic2d
import ./settings.nims

type Game = ref object of frag.Game

type
  Player = ref object
    width, height: float
    color: Color
    pos: Vector2d

proc getBounds(this: Player): Rect = Rect(x: this.pos.x.cint, y: this.pos.y.cint, w: this.width.cint, h: this.height.cint)

var p1, p2: Player
var rect1, rect2: Rect
method init(this: Game) =
  p1 = Player(width: 16, height: 100, color: color(0xff, 0xff, 0xff), pos: vector2d(20, 20))
  p2 = Player(width: 16, height: 100, color: color(0xff, 0xff, 0xff), pos: vector2d(400, 140))
  rect1 = p1.getBounds()
  rect2 = p2.getBounds()

method update(this: Game) =
  discard

method render(this: Game) =
  frag.draw.fillRect(this, addr(rect1), p1.color)
  frag.draw.fillRect(this, addr(rect2), p2.color)

frag.run[Game](cfg)
