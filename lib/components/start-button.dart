import 'dart:ui';
import 'package:boxgameflutter/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:boxgameflutter/view.dart';
import 'package:boxgameflutter/bgm.dart';

class StartButton {
  final BoxGame game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      game.screenSize.height * 0.75,
      game.tileSize * 6,
      game.tileSize * 3,
    );
    sprite = Sprite('ui/start-button.png');
  }
  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}
  void onTapDown() {
    game.activeView = View.playing;
    game.spawner.start();
    game.score = 0;
    BGM.play(trackIndex: 1, volume: 0.2);
  }
}
