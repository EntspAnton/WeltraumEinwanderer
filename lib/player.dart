import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/bullet.dart';
import 'package:weltraum_einwanderer/space_shooter_game.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame>, CollisionCallbacks {
  late final SpawnComponent _bulletSpawner;
  late final double screenSize;
  Player({this.screenSize = 100})
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

    _bulletSpawner = SpawnComponent(
      period: .5,
      selfPositioning: true,
      factory: (index) {
        return Bullet(
          position: position + Vector2(0, -height / 2),
          screenSize: screenSize / 3,
        );
      },
      autoStart: false,
    );

    game.add(_bulletSpawner);

    position = game.size / 2;

    add(RectangleHitbox());
  }

  void move(Vector2 delta) {
    position.add(delta * 1.8);
    if (position.x < screenSize / 2) {
      position.x = screenSize / 2;
    }

    if (position.x > game.size.x - screenSize / 2) {
      position.x = game.size.x - screenSize / 2;
    }
  }

  void startShooting() {
    _bulletSpawner.timer.start();
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
  }
}
