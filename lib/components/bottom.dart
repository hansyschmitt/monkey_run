import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/sprite.dart';

enum BottomStatus { waiting, moving }

class Bottom extends PositionComponent  {
  BottomGround firstGround;
  BottomGround secondGround;

  Size _screenSize;
  Rect _rect;
  Rect get rect => _rect;

  Bottom(Image spriteImage, Size screenSize) {
    _screenSize = screenSize;
    Sprite sprite = Sprite.fromImage(
      spriteImage,
      width: 168.0,
      height: 56.0,
      y: 0.0,
      x:292.0,
    );

    this.firstGround = BottomGround(sprite, screenSize);
    this.secondGround = BottomGround(sprite, screenSize);
  }

  void setPosition(double x, double y) {
    this.firstGround.x = x;
    this.firstGround.y = y;
    this.secondGround.x = this.firstGround.width;
    this.secondGround.y = y;
    _rect = Rect.fromLTWH(x, y, _screenSize.width, 130);
  }

  void update(double t){

      this.firstGround.x -= t * 120;
      this.secondGround.x -= t * 120;

      if (this.firstGround.x + this.firstGround.width <= 0) {
        this.firstGround.x = this.secondGround.x + this.secondGround.width;
      }

      if (this.secondGround.x + this.secondGround.width <= 0) {
        this.secondGround.x = this.firstGround.x + this.firstGround.width;
      }

  }


  @override
  void render(Canvas c) {
    firstGround.render(c);
    secondGround.render(c);
  }
}

class BottomGround extends SpriteComponent with Resizable {
  BottomGround(Sprite sprite, Size screenSize)
      : super.fromSprite(
      screenSize.width, 56.0, sprite);
}