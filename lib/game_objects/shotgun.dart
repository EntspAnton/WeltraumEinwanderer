import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/game_objects/bullet.dart';
import 'package:weltraum_einwanderer/game_objects/item_spawner.dart';
import 'package:weltraum_einwanderer/game_objects/spaceship_weapon.dart';

class ShotgunWeapon extends Weapon {
  ShotgunWeapon({required super.position, super.active})
      : super(itemType: ItemType.shotgunWeapon);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    bulletSpawner.add(SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) {
        return bulletFactory(index, 0);
      },
      autoStart: active,
    ));

    bulletSpawner.add(SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) {
        return bulletFactory(index, 0.2);
      },
      autoStart: active,
    ));

    bulletSpawner.add(SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) {
        return bulletFactory(index, -0.2);
      },
      autoStart: active,
    ));

    try {
      game.addAll(bulletSpawner);
    } catch (e) {
      print("Fuck All Fail\n$e");
    }
  }

  Bullet bulletFactory(int index, double angle) {
    return Bullet(
        position: position + Vector2(0, -50), screenSize: 15, angle: angle);
  }
}
