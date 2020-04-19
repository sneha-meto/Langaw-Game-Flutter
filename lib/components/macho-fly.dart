import 'package:boxgameflutter/box-game.dart';
import 'package:boxgameflutter/components/fly.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

class MachoFly extends Fly {
  double get speed => game.tileSize * 2.5;
  MachoFly(BoxGame game, double x, double y) : super(game) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('flies/macho-fly-1.png'));
    flyingSprite.add(Sprite('flies/macho-fly-2.png'));
    deadSprite = Sprite('flies/macho-fly-dead.png');

    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.35, game.tileSize * 1.35);
  }
}
