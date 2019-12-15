import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:monitos_en_fuga/components/background.dart';

import 'components/bottom.dart';
import 'components/monkey.dart';
import 'components/scorer.dart';
import 'main.dart';

class MonkeyGame extends BaseGame with TapDetector{
  Image _spriteImage;
  Image _monkeySpriteImage;
  Background background;
  Bottom bottom;
  double speedMultiplier = 1.0;
  Monkey firstMonkey;
  Monkey secondMonkey;
  Monkey thirdMonkey;
  int score = 0;
  Scorer _scorer;

  MonkeyGame(Image spriteImage, Image monkeySpriteImage, Size screenSize) {
    _spriteImage = spriteImage;
    _monkeySpriteImage = monkeySpriteImage;
    background = Background(spriteImage, screenSize);
    bottom = Bottom(spriteImage, screenSize);
    firstMonkey = Monkey(monkeySpriteImage, screenSize);
    secondMonkey = Monkey(monkeySpriteImage, screenSize);
    thirdMonkey = Monkey(monkeySpriteImage, screenSize);
    _scorer = Scorer(spriteImage, screenSize);

    initPositions(spriteImage);

    this
      ..add(background)
      //..add(bottom)
      ..add(firstMonkey)
      ..add(secondMonkey)
      ..add(thirdMonkey)
      ..add(_scorer);

  }
  @override
  void update(double t) {
    //bottom.update(t * 1.0);
    firstMonkey.update(t * 1.3*speedMultiplier);
    secondMonkey.update(t * 1.3*speedMultiplier);
    thirdMonkey.update(t * 1.2*speedMultiplier);
    Rect rect =thirdMonkey.toRect().intersect(secondMonkey.toRect());
    if(rect.height>0 && rect.width>0){
      thirdMonkey.visible=false;
      secondMonkey.visible=false;
    }
  }


  void initPositions(Image spriteImage) {
    //bottom.setPosition(0, Singleton.instance.screenSize.height - 130);
    firstMonkey.setPosition(0,Singleton.instance.screenSize.height - 270);
    secondMonkey.setPosition(generateRandomNegativePosition(),Singleton.instance.screenSize.height - 270);
    thirdMonkey.setPosition(generateRandomNegativePosition()*2,Singleton.instance.screenSize.height - 270);
  }
  double generateRandomNegativePosition(){
    Random rnd = Random();
    int min = 150, max = 200;
    int r = min + rnd.nextInt(max - min);
    return r*-1*1.0;
  }
  bool checkIfITapped(Monkey monkey, Offset offset) {
    if(monkey.ground.toRect().contains(offset)){
      print("Pressed");
      return true;
    }
    return false;
  }
  @override
  void onTapDown(TapDownDetails details) {
    if(checkIfITapped(firstMonkey, details.globalPosition)){
      score+=1;
      print(score);
      firstMonkey.visible=false;
      speedMultiplier+=0.8;
      _scorer.increase();
    }
    if(checkIfITapped(secondMonkey, details.globalPosition)){
      score+=1;
      print(score);
      secondMonkey.visible=false;
      speedMultiplier+=0.8;
      _scorer.increase();
    }
    if(checkIfITapped(thirdMonkey, details.globalPosition)){
      score+=1;
      print(score);
      thirdMonkey.visible=false;
      speedMultiplier+=0.8;
      _scorer.increase();
    }
    print("Player tap down on ${details.globalPosition.dx} - ${details.globalPosition.dy}");
  }
}