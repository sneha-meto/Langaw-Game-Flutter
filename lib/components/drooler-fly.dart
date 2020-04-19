import 'package:boxgameflutter/box-game.dart';
import 'package:boxgameflutter/components/fly.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class DroolerFly extends Fly {
  double get speed => game.tileSize * 1.5;
  DroolerFly(BoxGame game, double x, double y) : super(game) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('flies/drooler-fly-1.png'));
    flyingSprite.add(Sprite('flies/drooler-fly-2.png'));
    deadSprite = Sprite('flies/drooler-fly-dead.png');

    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);
  }
}
