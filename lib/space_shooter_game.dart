import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/events.dart';
import 'package:weltraum_einwanderer/bullet.dart';
import 'package:weltraum_einwanderer/coin.dart';
import 'package:weltraum_einwanderer/enemy.dart';
import 'package:weltraum_einwanderer/player.dart';
import 'package:weltraum_einwanderer/scoreCounter.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  // Game Values
  static const double enemySize = 30;
  static const double playerSize = 50;
  late Vector2 screenSize;

  bool gameRunning = false;

  // Main Game Objects
  late ScoreCounter scoreCounter;
  late Player player;
  late SpawnComponent enemySpawner;

  // Game-Over Effect
  late Function(int) gameOver;

  SpaceShooterGame({required this.gameOver, required this.screenSize});

  @override
  Future<void> onLoad() async {
    screenSize = size;
    // Parallax Background
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('stars_0.png'),
        ParallaxImageData('stars_1.png'),
        ParallaxImageData('stars_2.png'),
      ],
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 5),
    );

    enemySpawner = SpawnComponent(
        factory: (index) {
          return Enemy();
        },
        period: 1,
        area: Rectangle.fromLTWH(0, 0, screenSize.x, enemySize),
        within: false,
        autoStart: false);

    scoreCounter = ScoreCounter(position: Vector2(5, 20), screenHeight: 40);

    // Player
    player = Player(screenSize: playerSize, scoreCounter: scoreCounter);

    // Add Background to the Screen
    add(parallax);

    add(enemySpawner);
  }

  void startGame() {
    // scoreCounter.resetScore();
    player.position = screenSize / 2;
    add(player);

    add(scoreCounter);

    scoreCounter.resetScore();

    gameRunning = true;
    enemySpawner.timer.start();
  }

  void endGame() {
    remove(player);

    remove(scoreCounter);

    for (Component component in children) {
      if (component is Enemy || component is Coin || component is Bullet) {
        remove(component);
      }
    }

    gameRunning = false;
    enemySpawner.timer.stop();
    gameOver(scoreCounter.score);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    if (gameRunning) {
      player.move(info.delta.global);
    }
  }

  @override
  void onPanStart(DragStartInfo info) {
    if (gameRunning) {
      player.startShooting();
    }
  }

  @override
  void onPanEnd(DragEndInfo info) {
    if (gameRunning) {
      player.stopShooting();
    }
  }
}
