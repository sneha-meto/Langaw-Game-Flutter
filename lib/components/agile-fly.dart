import 'package:boxgameflutter/box-game.dart';
import 'package:boxgameflutter/components/fly.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class AgileFly extends Fly {
  double get speed => game.tileSize * 5;
  AgileFly(BoxGame game, double x, double y) : super(game) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('flies/agile-fly-1.png'));
    flyingSprite.add(Sprite('flies/agile-fly-2.png'));
    deadSprite = Sprite('flies/agile-fly-dead.png');

    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);
  }
}
