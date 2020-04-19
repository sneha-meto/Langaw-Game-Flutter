import 'package:boxgameflutter/box-game.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class LostView {
  final BoxGame game;
  Sprite sprite;
  Rect rect;

  LostView(this.game) {
    rect = Rect.fromLTWH(
        game.tileSize,
        (game.screenSize.height / 2) - (game.tileSize * 5),
        game.tileSize * 7,
        game.tileSize * 5);
    sprite = Sprite('bg/lose-splash.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}
}
