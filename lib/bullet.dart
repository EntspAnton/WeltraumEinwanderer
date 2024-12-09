import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/main.dart';

class Bullet extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
  late final double screenSize;
  Bullet({
    super.position,
    super.angle,
    this.screenSize = 25,
  }) : super(
          size: Vector2(screenSize, screenSize * 2),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'bullet.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(8, 16),
      ),
    );

    add(
      RectangleHitbox(collisionType: CollisionType.passive),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += dt * cos(angle + pi / 2) * -500;
    position.y += dt * sin(angle + pi / 2) * -500;

    if (position.y < -height) {
      removeFromParent();
    }
  }
}
