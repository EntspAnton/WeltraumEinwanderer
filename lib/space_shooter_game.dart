import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/events.dart';
import 'package:weltraum_einwanderer/enemy.dart';
import 'package:weltraum_einwanderer/player.dart';
import 'package:weltraum_einwanderer/scoreCounter.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  // Game Values
  static const double enemySize = 30;
  static const double playerSize = 50;

  int score = 0;

  // Main Game Objects
  late ScoreCounter scoreCounter;
  late Player player;
  late SpawnComponent enemySpawner;

  // Game-Over Effect
  late Function(int) gameOver;

  SpaceShooterGame({required this.gameOver});

  @override
  Future<void> onLoad() async {
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

    // Score Counter and Indicator
    scoreCounter = ScoreCounter(position: Vector2(5, 20), screenHeight: 40);

    // Player
    player = Player(screenSize: playerSize, scoreCounter: scoreCounter);

    enemySpawner = SpawnComponent(
        factory: (index) {
          return Enemy();
        },
        period: 1,
        area: Rectangle.fromLTWH(0, 0, size.x, enemySize),
        within: false);

    // Add Objects to the Screen
    add(parallax);

    add(enemySpawner);
    add(player);

    add(scoreCounter);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }

  @override
  void onPanStart(DragStartInfo info) {
    player.startShooting();
  }

  @override
  void onPanEnd(DragEndInfo info) {
    player.stopShooting();
  }
}
