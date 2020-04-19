import 'dart:ui';
import 'package:boxgameflutter/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:boxgameflutter/bgm.dart';

class MusicButton {
  final BoxGame game;
  bool isEnabled = true;
  Rect rect;
  Sprite enabledSprite;
  Sprite disabledSprite;
  MusicButton(this.game) {
    rect = Rect.fromLTWH(game.tileSize * 0.25, game.tileSize * 0.25,
        game.tileSize, game.tileSize);
    enabledSprite = Sprite('ui/icon-music-enabled.png');
    disabledSprite = Sprite('ui/icon-music-disabled.png');
  }

  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  void onTapDown() {
    if (isEnabled) {
      isEnabled = false;
      BGM.pause();
    } else {
      isEnabled = true;
      BGM.resume();
    }
  }
}
