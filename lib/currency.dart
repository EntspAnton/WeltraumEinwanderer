import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/space_shooter_game.dart';

class GoldCoin extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
  late final double screenSize;
  GoldCoin({
    super.position,
    this.screenSize = 25,
  }) : super(
          size: Vector2(screenSize, screenSize * 2),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'currency/coin-gold.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(16, 16),
      ),
    );

    add(
      RectangleHitbox(collisionType: CollisionType.passive),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += dt * cos(angle + pi / 2) * 250;
    position.y += dt * sin(angle + pi / 2) * 250;

    if (position.y < -height) {
      removeFromParent();
    }
  }
}
