import 'package:boxgameflutter/box-game.dart';
import 'package:boxgameflutter/view.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class CreditsButton {
  final BoxGame game;
  Sprite sprite;
  Rect rect;

  CreditsButton(this.game) {
    rect = Rect.fromLTWH(
        game.screenSize.width - game.tileSize * 1.25,
        game.screenSize.height - game.tileSize * 1.25,
        game.tileSize,
        game.tileSize);
    sprite = Sprite('ui/icon-credits.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    game.activeView = View.credits;
  }
}
