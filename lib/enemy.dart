import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/game_objects/bullet.dart';
import 'package:weltraum_einwanderer/coin.dart';
import 'package:weltraum_einwanderer/explosion.dart';
import 'package:weltraum_einwanderer/game_objects/fuck_all_weapon.dart';
import 'package:weltraum_einwanderer/game_objects/item_spawner.dart';
import 'package:weltraum_einwanderer/game_objects/shooter.dart';
import 'package:weltraum_einwanderer/game_objects/shotgun.dart';
import 'package:weltraum_einwanderer/game_objects/spiral_weapon.dart';
import 'package:weltraum_einwanderer/item.dart';
import 'package:weltraum_einwanderer/space_shooter_game.dart';
import 'package:weltraum_einwanderer/player.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame>, CollisionCallbacks {
  static double screenSize = 50;

  Enemy({super.position})
      : super(
          size: Vector2.all(screenSize),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
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

    position.y += dt * 200;

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

      game.add(game.itemSpawner.getRandomItem(position));
    }

    if (other is Player) {
      game.lifeCounter.looseLife();
      removeFromParent();
      game.add(Explosion(position: other.position, screenSize: screenSize * 3));
    }
  }
}
