import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/sprite.dart';

class Background extends PositionComponent with Resizable{
  BackgroundGround ground;

  Background(Image spriteImage, Size screenSize) {
    Sprite sprite = Sprite.fromImage(
      spriteImage,
      width: 144.0,
      height: 256.0,
      y: 0.0,
      x: 0.0,
    );

    this.ground = BackgroundGround(sprite, screenSize);
  }

  @override
  void render(Canvas c) {
    ground.render(c);
  }

  @override
  void update(double t) {
  }

}

class BackgroundGround extends SpriteComponent with Resizable {
  BackgroundGround(Sprite sprite, Size screenSize)
      : super.fromSprite(
      screenSize.width, screenSize.height, sprite);
}