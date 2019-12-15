import 'dart:collection';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'config.dart';
class Scorer extends PositionComponent  {
  int _score = 0;
  Size _screenSize;
  HashMap<String, Sprite> _digits;
  ScorerGround _oneDigitGround;
  ScorerGround _twoDigitGround;
  ScorerGround _threeDigitGround;

  Scorer(Image spriteImage, Size screenSize){
    _screenSize = screenSize;
    _initSprites(spriteImage);
    _renderDefaultView();
  }

  void increase() {
    _score++;
    _render();
    Flame.audio.play('point.wav');
  }

  void reset() {
    _score = 0;
    _render();
  }

  void _render(){
    var scoreStr = _score.toString().padLeft(3,'0');
    var numberList = scoreStr.split("").reversed.toList();
    print(numberList);
    for(var i = numberList.length - 1 ; i >= 0; i-- ) {
      var number = numberList[i];

      if (i == 0)
        _oneDigitGround.sprite = _digits[number.toString()];
      if (i == 1)
        _twoDigitGround.sprite = _digits[number.toString()];
      if (i == 2)
        _threeDigitGround.sprite = _digits[number.toString()];
    }
  }

  void _initSprites(Image spriteImage){
    _digits = HashMap.from({
      "0": Sprite.fromImage(
        spriteImage,
        width: 12.0,
        height: 18.0,
        x: 496.0,
        y: 60.0,
      ),
      "1": Sprite.fromImage(
        spriteImage,
        width: 12.0,
        height: 18.0,
        x: 136.0,
        y: 455.0,
      ),
      "2": Sprite.fromImage(
        spriteImage,
        width: 12.0,
        height: 18.0,
        x: 292.0,
        y: 160.0,
      ),
      "3": Sprite.fromImage(
        spriteImage,
        width: 12.0,
        height: 18.0,
        x: 306.0,
        y: 160.0,
      ),
      "4": Sprite.fromImage(
        spriteImage,
        width: 12.0,
        height: 18.0,
        x: SpritesPostions.fourthNumberX,
        y: SpritesPostions.fourthNumberY,
      ),
      "5": Sprite.fromImage(
        spriteImage,
        width: 12.0,
        height: 18.0,
        x: SpritesPostions.fifthNumberX,
        y: SpritesPostions.fifthNumberY,
      ),
      "6": Sprite.fromImage(
        spriteImage,
        width: 12.0,
        height: 18.0,
        x: SpritesPostions.sixthNumberX,
        y: SpritesPostions.sixthNumberY,
      ),
      "7": Sprite.fromImage(
        spriteImage,
        width: 12.0,
        height: 18.0,
        x: SpritesPostions.seventhNumberX,
        y: SpritesPostions.seventhNumberY,
      ),
      "8": Sprite.fromImage(
        spriteImage,
        width: 12.0,
        height: 18.0,
        x: SpritesPostions.eighthNumberX,
        y: SpritesPostions.eighthNumberY,
      ),
      "9": Sprite.fromImage(
        spriteImage,
        width: 12.0,
        height: 18.0,
        x: SpritesPostions.ninethNumberX,
        y: SpritesPostions.ninethNumberY,
      )
    });
  }

  void _renderDefaultView() {
    double defaultY = 80;
    var twoGroundX = (_screenSize.width - 36) / 2;
    _twoDigitGround = ScorerGround(_digits["0"]);
    this._twoDigitGround.x = twoGroundX;
    this._twoDigitGround.y = defaultY;
    _oneDigitGround = ScorerGround(_digits["0"]);

    _threeDigitGround = ScorerGround(_digits["0"]);
    this._threeDigitGround.x = _twoDigitGround.toRect().left - 220;
    this._threeDigitGround.y = defaultY-80;
    this._oneDigitGround.x = _twoDigitGround.toRect().right -130;
    this._oneDigitGround.y = defaultY - 80 ;
  }

  @override
  void render(Canvas c) {
    _twoDigitGround.render(c);
    _threeDigitGround.render(c);
    _oneDigitGround.render(c);

  }

  @override
  void update(double t) {
  }
}

class ScorerGround extends SpriteComponent with Resizable {
  ScorerGround(Sprite sprite, [int multiplier = 1])
      : super.fromSprite(
      36.0 * multiplier, 54, sprite);
}