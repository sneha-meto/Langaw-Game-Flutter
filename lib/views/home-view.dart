import 'package:boxgameflutter/box-game.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class HomeView {
  final BoxGame game;
  Sprite titleSprite;
  Rect titleRect;

  HomeView(this.game) {
    titleRect = Rect.fromLTWH(
        game.tileSize,
        (game.screenSize.height / 2) - (game.tileSize * 4),
        game.tileSize * 7,
        game.tileSize * 4);
    titleSprite = Sprite('branding/title.png');
  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }

  void update(double t) {}
}
