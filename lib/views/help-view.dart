import 'package:boxgameflutter/box-game.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class HelpView {
  final BoxGame game;
  Sprite sprite;
  Rect rect;

  HelpView(this.game) {
    rect = Rect.fromLTWH(
        game.tileSize * 0.5,
        (game.screenSize.height / 2) - (game.tileSize * 6),
        game.tileSize * 8,
        game.tileSize * 12);
    sprite = Sprite('ui/dialog-help.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }
}
