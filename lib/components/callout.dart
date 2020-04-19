import 'package:boxgameflutter/bgm.dart';
import 'package:boxgameflutter/components/fly.dart';
import 'package:boxgameflutter/view.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flame/flame.dart';

class Callout {
  final Fly fly;
  Rect rect;
  Sprite sprite;
  double value;

  TextPainter tp;
  TextStyle textStyle;
  Offset textOffset;

  Callout(this.fly) {
    sprite = Sprite('ui/callout.png');
    value = 1;
    tp = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    textStyle = TextStyle(
      color: Color(0xff000000),
      fontSize: 15,
    );
  }
  void render(Canvas c) {
    sprite.renderRect(c, rect);
    tp.paint(c, textOffset);
  }

  void update(double t) {
    if (fly.game.activeView == View.playing) {
      value = value - 0.5 * t;
      if (value <= 0) {
        if (fly.game.soundButton.isEnabled) {
          Flame.audio.play(
              'sfx/haha' + (fly.game.rnd.nextInt(5) + 1).toString() + '.mp3');
        }
        BGM.play(trackIndex: 0);
        fly.game.activeView = View.lost;
      }
    }
    rect = Rect.fromLTWH(
      fly.flyRect.left - (fly.game.tileSize * 0.25),
      fly.flyRect.top - (fly.game.tileSize * 0.5),
      fly.game.tileSize * 0.75,
      fly.game.tileSize * 0.75,
    );
    tp.text = TextSpan(
      text: (value * 10).toInt().toString(),
      style: textStyle,
    );
    tp.layout();
    textOffset = Offset(
      rect.center.dx - (tp.width / 2),
      rect.top + (rect.height * 0.4) - (tp.height / 2),
    );
  }
}
