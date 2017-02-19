import ../../src/frag
import basic2d
import sdl2/sdl

type Game = ref object of frag.Game

type
  Player = ref object
    width, height: float
    color: Color
    pos: Vector2d

proc getBounds(this: Player): Rect = Rect(x: this.pos.x.int, y: this.pos.y.int, w: this.width.int, h: this.height.int)

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

frag.run[Game]()
