import 'dart:ui';
import 'package:boxgameflutter/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:boxgameflutter/bgm.dart';

class SoundButton {
  final BoxGame game;
  bool isEnabled = true;
  Rect rect;
  Sprite enabledSprite;
  Sprite disabledSprite;
  SoundButton(this.game) {
    rect = Rect.fromLTWH(game.tileSize * 1.25, game.tileSize * 0.25,
        game.tileSize, game.tileSize);
    enabledSprite = Sprite('ui/icon-sound-enabled.png');
    disabledSprite = Sprite('ui/icon-sound-disabled.png');
  }

  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  void onTapDown() {
    isEnabled = !isEnabled;
  }
}
