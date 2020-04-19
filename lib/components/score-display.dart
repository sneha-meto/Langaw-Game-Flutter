import 'package:boxgameflutter/box-game.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/painting.dart';

class ScoreDisplay {
  final BoxGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;
  ScoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textStyle = TextStyle(
      fontSize: 90,
      color: Color(0xffffffff),
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );
    position = Offset.zero;
  }
  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter.text?.text ?? '') != game.score.toString()) {
      painter.text = TextSpan(
        text: game.score.toString(),
        style: textStyle,
      );
      painter.layout();
      position = Offset((game.screenSize.width / 2) - (painter.width / 2),
          (game.screenSize.height * 0.25) - (painter.height / 2));
    }
  }
}
