import 'package:boxgameflutter/box-game.dart';
import 'package:boxgameflutter/view.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class HelpButton {
  final BoxGame game;
  Sprite sprite;
  Rect rect;

  HelpButton(this.game) {
    rect = Rect.fromLTWH(
        game.tileSize * 0.25,
        game.screenSize.height - game.tileSize * 1.25,
        game.tileSize,
        game.tileSize);
    sprite = Sprite('ui/icon-help.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    game.activeView = View.help;
  }
}
