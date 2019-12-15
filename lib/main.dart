import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'monkey_game.dart';
void main() async {
  // initial settings
  Flame.audio.disableLog();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIOverlays([]);

  var sprite = await Flame.images.loadAll(["sprite.png","monkeysprite.png"]);
  var screenSize = await Flame.util.initialDimensions();
  Singleton.instance.screenSize = screenSize;
  var monkeyGame = MonkeyGame(sprite[0],sprite[1], screenSize);
  runApp(MaterialApp(
    title: 'MonkeyApp',
    home: Scaffold(
      body: GameWrapper(monkeyGame),
    ),
  ));

}

class GameWrapper extends StatelessWidget {
  final MonkeyGame monkeyGame;
  GameWrapper(this.monkeyGame);

  @override
  Widget build(BuildContext context) {
    return monkeyGame.widget;
  }
}

class Singleton {
  Size screenSize;
  Singleton._privateConstructor();
  static final Singleton instance = Singleton._privateConstructor();
}