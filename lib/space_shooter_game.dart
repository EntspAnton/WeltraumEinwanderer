import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/events.dart';
import 'package:weltraum_einwanderer/enemy.dart';
import 'package:weltraum_einwanderer/player.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Player player;

  static const double enemySize = 30;
  static const double playerSize = 50;

  int score = 0;

  late TextComponent scoreText;

  @override
  Future<void> onLoad() async {
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
    add(parallax);

    player = Player(screenSize: playerSize);
    add(player);

    add(
      SpawnComponent(
          factory: (index) {
            return Enemy();
          },
          period: 1,
          area: Rectangle.fromLTWH(0, 0, size.x, enemySize),
          within: false),
    );

    scoreText = TextComponent(
        text: score.toString(),
        position: Vector2(size.x / 2, 50),
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
          style: TextStyle(
            fontSize: 48.0,
            color: Colors.amber.shade50,
          ),
        ));

    add(scoreText);
  }

  @override
  void update(double dt) {
    super.update(dt);
    scoreText.text = score.toString();
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
