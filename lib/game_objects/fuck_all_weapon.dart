import 'dart:math';

import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/game_objects/bullet.dart';
import 'package:weltraum_einwanderer/game_objects/item_spawner.dart';
import 'package:weltraum_einwanderer/game_objects/spaceship_weapon.dart';

class FuckAllWeapon extends Weapon {
  FuckAllWeapon({required super.position, super.active})
      : super(itemType: ItemType.fuckYouAllWeapon);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Random random = Random();

    bulletSpawner.add(SpawnComponent(
      period: .05,
      selfPositioning: true,
      factory: (index) {
        return Bullet(
            position: position,
            screenSize: 15,
            angle: random.nextDouble() * pi * 2);
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
