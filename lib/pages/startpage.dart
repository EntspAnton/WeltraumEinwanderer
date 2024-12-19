import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weltraum_einwanderer/space_shooter_game.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  final level = 1;

  @override
  State<StatefulWidget> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late SpaceShooterGame game;
  late GameWidget<SpaceShooterGame> gameWidget;
  late Widget titleScreen;
  bool gameRunning = false;
  bool moneyLoaded = false;

  int money = 0;

  @override
  void initState() {
    super.initState();

    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;

    // Dimensions in physical pixels (px)
    Size size = view.physicalSize / view.devicePixelRatio;

    game = SpaceShooterGame(
        gameOver: endGame, screenSize: Vector2(size.width, size.height));

    titleScreen = _getTitleScreen();
    loadMoney().then((result) {
      titleScreen = _getTitleScreen();
    });

    gameWidget = GameWidget(game: game);
  }

  Widget _getTitleScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
          child: Text(
            'Weltraum Einwanderer',
            style: GoogleFonts.quantico(
              textStyle: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 165, 197, 243)),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Text(
            'Money: $money',
            style: GoogleFonts.quantico(
              textStyle: const TextStyle(
                  fontSize: 40, color: Color.fromARGB(255, 165, 197, 243)),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: _startGame,
            child: Text(
              'Start Game',
              style: GoogleFonts.quantico(),
            )),
      ],
    );
  }

  /// Load the initial counter value from persistent storage on start,
  /// or fallback to 0 if it doesn't exist.
  Future<void> loadMoney() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      money = prefs.getInt('total_money') ?? 0;
      moneyLoaded = true;
    });
  }

  void _startGame() {
    print('start');
    setState(() {
      titleScreen = Container();
    });
    game.startGame();
  }

  Future<void> endGame(int score) async {
    print("game over");
    money += score;

    // Load and obtain the shared preferences for this app.
    final prefs = await SharedPreferences.getInstance();

    // Save the counter value to persistent storage under the 'counter' key.
    await prefs.setInt('total_money', money);
    gameRunning = false;
    setState(() {
      titleScreen = _getTitleScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   bottomOpacity: 0,
      //   //toolbarOpacity: 0,
      //   title: Text(
      //     'Weltraum Einwanderer',
      //     style: GoogleFonts.quantico(),
      //   ),
      // ),
      body: SafeArea(
          child: Center(
        child: Stack(
          children: [
            gameWidget,
            titleScreen,
          ],
        ),
      )),
    );
  }
}
