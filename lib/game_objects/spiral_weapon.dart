import 'dart:math';

import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/game_objects/bullet.dart';
import 'package:weltraum_einwanderer/game_objects/item_spawner.dart';
import 'package:weltraum_einwanderer/game_objects/spaceship_weapon.dart';

class SpiralWeapon extends Weapon {
  SpiralWeapon({required super.position, super.active})
      : super(itemType: ItemType.spiralWeapon);

  double angle = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    bulletSpawner.add(SpawnComponent(
      period: .03,
      selfPositioning: true,
      factory: (index) {
        angle += pi / 20;
        if (angle > pi * 2) {
          angle -= pi * 2;
        }
        return Bullet(
          position: position,
          screenSize: 15,
          angle: angle,
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
