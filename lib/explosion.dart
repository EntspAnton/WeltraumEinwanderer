import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/space_shooter_game.dart';

class Explosion extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
  late final double screenSize;
  Explosion({
    super.position,
    this.screenSize = 150,
  }) : super(
          size: Vector2.all(screenSize),
          anchor: Anchor.center,
          removeOnFinish: true,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'explosion.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: .1,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );
  }
}
