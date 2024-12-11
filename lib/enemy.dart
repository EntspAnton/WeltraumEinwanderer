import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/bullet.dart';
import 'package:weltraum_einwanderer/explosion.dart';
import 'package:weltraum_einwanderer/main.dart';
import 'package:weltraum_einwanderer/player.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame>, CollisionCallbacks {
  double screenSize;
  late Player player;

  Enemy({super.position, this.screenSize = 50, required this.player})
      : super(
          size: Vector2.all(screenSize),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    Vector2 playerDirection = (position - player.position);
    playerDirection /= playerDirection.length;

    angle = atan2(playerDirection.y, playerDirection.x) - pi / 2;
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'enemy.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2.all(16),
      ),
    );

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x += dt * cos(angle + pi / 2) * -200;
    position.y += dt * sin(angle + pi / 2) * -200;

    if (position.y > game.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet) {
      removeFromParent();
      other.removeFromParent();
      game.add(Explosion(position: position, screenSize: screenSize * 1.5));
    }
  }
}
