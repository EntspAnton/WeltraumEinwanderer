import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/space_shooter_game.dart';

class Item extends PositionComponent with HasGameReference<SpaceShooterGame> {
  late final double screenSize;
  late final int fallingSpeed;

  late final item;

  Item(
      {required super.position,
      required this.screenSize,
      required this.item,
      this.fallingSpeed = 250})
      : super(
          size: Vector2(screenSize, screenSize),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(
      RectangleHitbox(collisionType: CollisionType.passive),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += dt * fallingSpeed;

    if (position.y < -height) {
      removeFromParent();
    }
  }
}
