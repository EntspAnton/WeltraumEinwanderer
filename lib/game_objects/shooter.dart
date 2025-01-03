import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/game_objects/bullet.dart';
import 'package:weltraum_einwanderer/game_objects/item_spawner.dart';
import 'package:weltraum_einwanderer/game_objects/spaceship_weapon.dart';

class ShooterWeapon extends Weapon {
  ShooterWeapon({required super.position, super.active})
      : super(itemType: ItemType.shooterWeapon);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    bulletSpawner.add(SpawnComponent(
      period: .5,
      selfPositioning: true,
      factory: (index) {
        return Bullet(
          position: position + Vector2(0, -50),
          screenSize: 15,
        );
      },
      autoStart: active,
    ));

    try {
      game.addAll(bulletSpawner);
    } catch (e) {
      print("Fuck All Fail\n$e");
    }
  }
}
