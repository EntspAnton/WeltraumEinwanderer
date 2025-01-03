import 'package:flame/components.dart';
import 'package:weltraum_einwanderer/space_shooter_game.dart';

class LifeCounter extends PositionComponent
    with HasGameReference<SpaceShooterGame> {
  late final double screenSize;
  late final int lifes;
  List<HeartSprite> lifeSprites = [];
  LifeCounter({
    super.position,
    this.screenSize = 50,
    required this.lifes,
  });

  @override
  Future<void> onLoad() async {
    for (int i = 0; i < lifes; i++) {
      print("adding Life");
      Vector2 spritePosition = Vector2(position.x, position.y);

      spritePosition.x -= i * screenSize * 1.2;

      print(spritePosition.x);
      print(spritePosition.y);

      HeartSprite lifeSprite =
          HeartSprite(position: spritePosition, screenSize: screenSize);
      lifeSprites.add(lifeSprite);
      add(lifeSprite);
    }
    print(lifeSprites.length);
  }

  void looseLife() {
    game.endGame();
    // print("lost Life");
    // print(lifeSprites.length);
    // HeartSprite lostLife = lifeSprites.removeLast();
    // remove(lostLife);
    // print(lifeSprites.length);

    // if (lifeSprites.isEmpty) {
    //   game.endGame();
    // }
  }

  void resetScore() {
    for (HeartSprite life in lifeSprites) {
      remove(life);
    }
    lifeSprites = [];
    for (int i = 0; i < lifes; i++) {
      Vector2 spritePosition = position;

      spritePosition.x -= i * screenSize * 1.2;

      HeartSprite lifeSprite =
          HeartSprite(position: spritePosition, screenSize: screenSize);
      lifeSprites.add(lifeSprite);
      add(lifeSprite);
    }
  }
}

class HeartSprite extends SpriteComponent
    with HasGameReference<SpaceShooterGame> {
  late final double screenSize;
  HeartSprite({
    super.position,
    this.screenSize = 50,
  }) : super(
          size: Vector2(screenSize, screenSize),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await game.loadSprite('heart.png',
        srcPosition: Vector2.all(0), srcSize: Vector2.all(16));
  }
}
