import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/space_shooter_game.dart';

class Coin extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
  late final double screenSize;
  late final String spriteFile;
  late final int value;

  late final int fallingSpeed;

  Coin(
      {required super.position,
      required this.spriteFile,
      required this.value,
      this.screenSize = 25,
      this.fallingSpeed = 250})
      : super(
          size: Vector2(screenSize, screenSize),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      spriteFile,
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(16, 16),
      ),
    );

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

class GoldCoin extends Coin {
  GoldCoin({
    required super.position,
    super.screenSize = 25,
  }) : super(
          spriteFile: "currency/coin-gold.png",
          value: 1,
        );
}

class BlueCoin extends Coin {
  BlueCoin({
    required super.position,
    super.screenSize = 25,
  }) : super(
          spriteFile: "currency/coin-blue.png",
          value: 5,
        );
}

class AzureCoin extends Coin {
  AzureCoin({
    required super.position,
    super.screenSize = 25,
  }) : super(
          spriteFile: "currency/coin-azure.png",
          value: 10,
        );
}

class GreenCoin extends Coin {
  GreenCoin({
    required super.position,
    super.screenSize = 25,
  }) : super(
          spriteFile: "currency/coin-green.png",
          value: 25,
        );
}

class PurpleCoin extends Coin {
  PurpleCoin({
    required super.position,
    super.screenSize = 25,
  }) : super(
          spriteFile: "currency/coin-purple.png",
          value: 50,
        );
}
