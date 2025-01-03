import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/coin.dart';
import 'package:weltraum_einwanderer/game_objects/fuck_all_weapon.dart';
import 'package:weltraum_einwanderer/game_objects/shooter.dart';
import 'package:weltraum_einwanderer/game_objects/shotgun.dart';
import 'package:weltraum_einwanderer/game_objects/spaceship_weapon.dart';
import 'package:weltraum_einwanderer/game_objects/spiral_weapon.dart';
import 'package:weltraum_einwanderer/item.dart';
import 'package:weltraum_einwanderer/score_counter.dart';
import 'package:weltraum_einwanderer/space_shooter_game.dart';
import 'package:weltraum_einwanderer/weapon_item.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame>, CollisionCallbacks {
  late final double screenSize;
  late final ScoreCounter scoreCounter;
  late Weapon weapon;
  bool shootingActive = false;

  Player(
      {this.screenSize = 100, required this.scoreCounter, required this.weapon})
      : super(
          size: Vector2(screenSize, screenSize * 1.5),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(32, 48),
      ),
    );

    position = game.size / 2;

    add(RectangleHitbox());
    add(weapon);
  }

  void move(Vector2 delta) {
    position.add(delta * 1.8);
    if (position.x < screenSize / 2) {
      position.x = screenSize / 2;
    }

    if (position.x > game.size.x - screenSize / 2) {
      position.x = game.size.x - screenSize / 2;
    }

    if (position.y < screenSize / 2) {
      position.y = screenSize / 2;
    }

    if (position.y > game.size.y - screenSize / 2) {
      position.y = game.size.y - screenSize / 2;
    }

    weapon.position = position;
  }

  void startShooting() {
    if (!shootingActive) {
      weapon.startShooting();
      shootingActive = true;
    }
  }

  void stopShooting() {
    if (shootingActive) {
      weapon.stopShooting();
      shootingActive = false;
    }
  }

  void changeWeapon(Weapon newWeapon) {
    if (shootingActive) {
      weapon.stopShooting();
    }
    weapon.removeFromParent();
    weapon = newWeapon;
    add(weapon);

    if (shootingActive) {
      print("Continue Shooting");
      weapon.startShooting();
    }
    game.itemSpawner.currentWeapon = weapon.itemType;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Coin) {
      scoreCounter.updateScore(other.value);
      other.removeFromParent();
    }

    if (other is WeaponItem) {
      Weapon newWeapon;
      print("shooting: $shootingActive");
      if (other is SpiralWeaponItem) {
        print("Spiral");
        newWeapon = SpiralWeapon(position: position, active: shootingActive);
      } else if (other is FuckYouAllWeaponItem) {
        print("Fuck You");
        newWeapon = FuckAllWeapon(position: position, active: shootingActive);
      } else if (other is ShotgunWeaponItem) {
        print("Shotgun");
        newWeapon = ShotgunWeapon(position: position, active: shootingActive);
      } else {
        print("Shooter");
        newWeapon = ShooterWeapon(position: position, active: shootingActive);
      }
      changeWeapon(newWeapon);
      other.removeFromParent();
    }
  }
}
