import 'package:boxgameflutter/box-game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HighscoreDisplay {
  final BoxGame game;
  TextPainter textPainter;
  TextStyle textStyle;
  Offset position;

  HighscoreDisplay(this.game) {
    textPainter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    Shadow shadow =
        Shadow(color: Color(0xff000000), blurRadius: 3, offset: Offset.zero);
    textStyle = TextStyle(
        color: Color(0xff000000),
        fontSize: 30,
        shadows: [shadow, shadow, shadow, shadow]);
    position = Offset.zero;
    updateHighscore();
  }
  void updateHighscore() {
    int highscore = game.storage.getInt('highscore');
    textPainter.text = TextSpan(
      text: 'Highscore: ' + highscore.toString(),
      style: textStyle,
    );
    textPainter.layout();
    position = Offset(
        game.screenSize.width - (game.tileSize * 0.25) - textPainter.width,
        game.tileSize * 0.25);
  }

  void render(Canvas c) {
    textPainter.paint(c, position);
  }
}
