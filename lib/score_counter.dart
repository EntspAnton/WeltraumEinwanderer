import 'package:flame/components.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weltraum_einwanderer/space_shooter_game.dart';

class ScoreCounter extends PositionComponent
    with HasGameReference<SpaceShooterGame> {
  late final double screenHeight;
  int score = 0;
  late TextComponent scoreText;
  ScoreCounter({
    super.position,
    this.screenHeight = 50,
  });

  @override
  Future<void> onLoad() async {
    final moneySprite =
        MoneySprite(position: position, screenSize: screenHeight);

    scoreText = TextComponent(
        text: score.toString(),
        position: position + Vector2(screenHeight, 0),
        anchor: Anchor.centerLeft,
        textRenderer: TextPaint(
          style: GoogleFonts.quantico(
            fontSize: screenHeight,
          ),
        ));

    add(moneySprite);
    add(scoreText);
  }

  void updateScore(int amount) {
    score += amount;
    scoreText.text = score.toString();
  }

  void resetScore() {
    score = 0;
    scoreText.text = score.toString();
  }
}

class MoneySprite extends SpriteComponent
    with HasGameReference<SpaceShooterGame> {
  late final double screenSize;
  MoneySprite({
    super.position,
    this.screenSize = 50,
  }) : super(
          size: Vector2(screenSize, screenSize),
          anchor: Anchor.centerLeft,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await game.loadSprite('currency/coin-gold.png',
        srcPosition: Vector2.all(0), srcSize: Vector2.all(16));
  }
}
