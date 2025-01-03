import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/game_objects/item_spawner.dart';
import 'package:weltraum_einwanderer/space_shooter_game.dart';

class WeaponItem extends SpriteComponent
    with HasGameReference<SpaceShooterGame> {
  late final double screenSize;
  late final String spriteFile;

  late final int fallingSpeed;

  late final ItemType itemType;

  WeaponItem(
      {required super.position,
      required this.spriteFile,
      required this.itemType,
      this.screenSize = 25,
      this.fallingSpeed = 250})
      : super(
          size: Vector2(screenSize, screenSize),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await game.loadSprite(spriteFile,
        srcPosition: Vector2.all(0), srcSize: Vector2.all(16));

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

class SpiralWeaponItem extends WeaponItem {
  SpiralWeaponItem({
    required super.position,
    super.screenSize = 25,
  }) : super(spriteFile: "items/spiral.png", itemType: ItemType.spiralWeapon);
}

class ShooterWeaponItem extends WeaponItem {
  ShooterWeaponItem({
    required super.position,
    super.screenSize = 25,
  }) : super(spriteFile: "items/shooter.png", itemType: ItemType.shooterWeapon);
}

class FuckYouAllWeaponItem extends WeaponItem {
  FuckYouAllWeaponItem({
    required super.position,
    super.screenSize = 25,
  }) : super(
            spriteFile: "items/questionmark.png",
            itemType: ItemType.fuckYouAllWeapon);
}

class ShotgunWeaponItem extends WeaponItem {
  ShotgunWeaponItem({
    required super.position,
    super.screenSize = 25,
  }) : super(spriteFile: "items/shotgun.png", itemType: ItemType.shooterWeapon);
}
