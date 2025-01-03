import 'dart:async';

import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/game_objects/item_spawner.dart';
import 'package:weltraum_einwanderer/space_shooter_game.dart';

class Weapon extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
  List<SpawnComponent> bulletSpawner = [];

  late bool active;
  late ItemType itemType;

  Weapon(
      {required super.position, this.active = false, required this.itemType});

  void startShooting() {
    for (SpawnComponent spawner in bulletSpawner) {
      spawner.timer.start();
    }
  }

  void stopShooting() {
    for (SpawnComponent spawner in bulletSpawner) {
      spawner.timer.stop();
    }
  }

  void move(Vector2 position) {
    position = position;
  }
}
