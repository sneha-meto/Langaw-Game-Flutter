import 'dart:math';
import 'dart:ui';
import 'package:boxgameflutter/components/agile-fly.dart';
import 'package:boxgameflutter/components/credits-button.dart';
import 'package:boxgameflutter/components/help-button.dart';
import 'package:boxgameflutter/components/highscore-display.dart';
import 'package:boxgameflutter/components/hungry-fly.dart';
import 'package:boxgameflutter/components/score-display.dart';
import 'package:boxgameflutter/controllers/spawner.dart';
import 'package:boxgameflutter/views/credits-view.dart';
import 'package:boxgameflutter/views/help-view.dart';
import 'package:boxgameflutter/views/home-view.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/flame.dart';
import 'components/drooler-fly.dart';
import 'components/fly.dart';
import 'components/backyard.dart';
import 'components/house-fly.dart';
import 'components/macho-fly.dart';
import 'view.dart';
import 'components/start-button.dart';
import 'package:boxgameflutter/views/lost-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bgm.dart';
import 'components/sound-button.dart';
import 'components/music-button.dart';

class BoxGame extends Game {
  Size screenSize;
  double tileSize;
  List<Fly> flies;
  Random rnd;
  Backyard background;
  View activeView = View.home;
  HomeView homeView;
  StartButton startButton;
  LostView lostView;
  FlySpawner spawner;
  HelpButton helpButton;
  CreditsButton creditsButton;
  HelpView helpView;
  CreditsView creditsView;
  int score;
  ScoreDisplay scoreDisplay;
  final SharedPreferences storage;
  HighscoreDisplay highscoreDisplay;
  MusicButton musicButton;
  SoundButton soundButton;

  BoxGame(this.storage) {
    initialize();
  }

  void initialize() async {
    flies = List<Fly>();
    resize(await Flame.util.initialDimensions());
    background = Backyard(this);
    homeView = HomeView(this);
    startButton = StartButton(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    lostView = LostView(this);
    rnd = Random();
    spawner = FlySpawner(this);
    creditsView = CreditsView(this);
    helpView = HelpView(this);
    score = 0;
    scoreDisplay = ScoreDisplay(this);
    highscoreDisplay = HighscoreDisplay(this);
    BGM.play(trackIndex: 0);
    soundButton = SoundButton(this);
    musicButton = MusicButton(this);
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize * 1.35);
    double y = (rnd.nextDouble() * (screenSize.height - (tileSize * 2.85))) +
        (tileSize * 1.5);
    switch (rnd.nextInt(5)) {
      case 0:
        flies.add(HouseFly(this, x, y));
        break;
      case 1:
        flies.add(DroolerFly(this, x, y));
        break;
      case 2:
        flies.add(AgileFly(this, x, y));
        break;
      case 3:
        flies.add(MachoFly(this, x, y));
        break;
      case 4:
        flies.add(HungryFly(this, x, y));
        break;
    }
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;
    //handle taps here
    //reverse order of rendering, ie: start button on top & has more priority
    if (!isHandled &&
        startButton.rect.contains(d.globalPosition)) if (activeView ==
            View.home ||
        activeView == View.lost) {
      startButton.onTapDown();
      isHandled = true;
    }

    if (!isHandled &&
        helpButton.rect.contains(d.globalPosition)) if (activeView ==
            View.home ||
        activeView == View.lost) {
      helpButton.onTapDown();
      isHandled = true;
    }

    if (!isHandled &&
        creditsButton.rect.contains(d.globalPosition)) if (activeView ==
            View.home ||
        activeView == View.lost) {
      creditsButton.onTapDown();
      isHandled = true;
    }

    if (!isHandled) if (activeView == View.credits || activeView == View.help) {
      activeView = View.home;
      isHandled = true;
    }
    //music & sound buttons
    if (!isHandled && soundButton.rect.contains(d.globalPosition)) {
      soundButton.onTapDown();
      isHandled = true;
    }
    if (!isHandled && musicButton.rect.contains(d.globalPosition)) {
      musicButton.onTapDown();
      isHandled = true;
    }

    if (!isHandled) {
      bool didHitAFly = false;
      flies.forEach((Fly fly) {
        if (fly.flyRect.contains(d.globalPosition)) {
          fly.onTapDown();
          isHandled = true;
          didHitAFly = true;
        }
      });
      if (activeView == View.playing && !didHitAFly) {
        if (soundButton.isEnabled) {
          Flame.audio
              .play('sfx/haha' + (rnd.nextInt(5) + 1).toString() + '.mp3');
        }
        BGM.play(trackIndex: 0);
        activeView = View.lost;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    //rendering happens in coded order, last line on top of prev line
    //screen background
    background.render(canvas);

    //score and highscore
    if (activeView == View.playing) {
      scoreDisplay.render(canvas);
      highscoreDisplay.render(canvas);
    }

    //fly
    flies.forEach((Fly fly) => fly.render(canvas));
    //title
    if (activeView == View.home) {
      homeView.render(canvas);
    }
    //start button,credits button, help button
    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
      creditsButton.render(canvas);
      helpButton.render(canvas);
    }
    //lost splash
    if (activeView == View.lost) {
      lostView.render(canvas);
    }

    //music & sound buttons
    soundButton.render(canvas);
    musicButton.render(canvas);

    //help dialog
    if (activeView == View.help) {
      helpView.render(canvas);
    }
    //credits dialog
    if (activeView == View.credits) {
      creditsView.render(canvas);
    }
  }

  @override
  void update(double t) {
    flies.forEach((Fly fly) => fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);
    spawner.update(t);
    if (activeView == View.playing) scoreDisplay.update(t);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }
}
