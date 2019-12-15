import 'dart:math';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

class Monkey extends PositionComponent  {
  bool visible=true;
  Size _screenSize;
  MonkeyGround ground;
  bool isJumping=false;
  int jumpCount = 0;
  Monkey(Image spriteImage, Size screenSize) {
    _screenSize = screenSize;
    List<Sprite> sprites = [
      Sprite.fromImage(
        spriteImage,
        width: 67,
        height: 71,
        y: 43,
        x: 43,
      ),
      Sprite.fromImage(
        spriteImage,
        width: 67,
        height: 71,
        y: 43,
        x: 135,
      ),
      Sprite.fromImage(
        spriteImage,
        width: 67,
        height: 71,
        y: 43,
        x: 230,
      ),
      Sprite.fromImage(
        spriteImage,
        width: 67,
        height: 71,
        y: 43,
        x: 320,
      ),
      Sprite.fromImage(
        spriteImage,
        width: 67,
        height: 71,
        y: 43,
        x: 417,
      )
    ];

    var animatedMonkey = new Animation.spriteList(sprites, stepTime: 0.15,loop: true);
    this.ground = MonkeyGround(animatedMonkey);

  }

  void setPosition(double x, double y) {
    this.ground.x = x;
    this.ground.y = y;
  }


  @override
  void render(Canvas c) {
    if(visible){
      this.ground.render(c);
    }
  }

  double generateRandomNegativePosition(){
    Random rnd = math.Random();
    int min = 100, max = 200;
    int r = min + rnd.nextInt(max - min);
    return r*-1*1.0;
  }
  @override
  void update(double t) {
    this.ground.update(t);
    this.ground.x += t * 40 ;
    if(this.ground.x > _screenSize.width){
      visible=true;
      this.ground.x = generateRandomNegativePosition();
    }
  }

}


class MonkeyGround extends AnimationComponent {
  bool showAnimation = true;

  MonkeyGround(Animation animation)
      : super(67, 71, animation);

  @override
  void update(double t){
      super.update(t);
  }
}