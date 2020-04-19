import 'package:boxgameflutter/box-game.dart';
import 'package:boxgameflutter/components/fly.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class HungryFly extends Fly {
  HungryFly(BoxGame game, double x, double y) : super(game) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('flies/hungry-fly-1.png'));
    flyingSprite.add(Sprite('flies/hungry-fly-2.png'));
    deadSprite = Sprite('flies/hungry-fly-dead.png');

    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.1, game.tileSize * 1.1);
  }
}
