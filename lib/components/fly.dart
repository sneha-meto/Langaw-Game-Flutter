//gives access to canvas class
import 'dart:ui';
import 'package:boxgameflutter/box-game.dart';
import 'package:boxgameflutter/view.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'callout.dart';
import 'package:flame/flame.dart';

class Fly {
  final BoxGame game;
  Rect flyRect;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  Offset targetLocation;
  Callout callout;

  Fly(this.game) {
    setTargetLocation();
    callout = Callout(this);
  }

  //flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);

  void render(Canvas c) {
    //c.drawRect(flyRect.inflate(flyRect.width / 2), Paint()..color = Color(0x77ffffff));
    if (isDead) {
      deadSprite.renderRect(c, flyRect.inflate(flyRect.width / 2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()]
          .renderRect(c, flyRect.inflate(flyRect.width / 2));

      if (game.activeView == View.playing) {
        callout.render(c);
      }
    }
    //c.drawRect(flyRect, Paint()..color = Color(0x88000000));
  }

  void update(double t) {
    if (isDead) {
      //falling animation
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);
    } else {
      //flying animation
      flyingSpriteIndex += 30 * t;
      while (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
      //moving animation
      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget =
            Offset.fromDirection(toTarget.direction, stepDistance);
        flyRect = flyRect.shift(stepToTarget);
      } else {
        flyRect = flyRect.shift(toTarget);
        setTargetLocation();
      }

      callout.update(t);
    }

    if (flyRect.top > game.screenSize.height) {
      isOffScreen = true;
    }
  }

  void onTapDown() {
    if (!isDead) {
      if (game.soundButton.isEnabled) {
        Flame.audio
            .play('sfx/ouch' + (game.rnd.nextInt(11) + 1).toString() + '.mp3');
      }
      isDead = true;

      if (game.activeView == View.playing) {
        game.score++;

        if (game.score > (game.storage.getInt('highscore') ?? 0)) {
          game.storage.setInt('highscore', game.score);
          game.highscoreDisplay.updateHighscore();
        }
      }
    }
  }

  double get speed => game.tileSize * 3;

  void setTargetLocation() {
    double x =
        game.rnd.nextDouble() * (game.screenSize.width - game.tileSize * 1.35);
    double y = (game.rnd.nextDouble() *
            (game.screenSize.height - (game.tileSize * 2.85))) +
        (game.tileSize * 1.5);

    targetLocation = Offset(x, y);
  }
}
