import 'dart:io';

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
  Widget? _content;
  bool gameRunning = false;
  bool moneyLoaded = false;

  int money = 0;

  @override
  void initState() {
    super.initState();
    loadMoney().then((result) {
      _setTitleScreen();
    });
  }

  void _setTitleScreen() {
    _content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Money: ',
                style: GoogleFonts.quantico(),
              ),
              Text(
                money.toString(),
                style: GoogleFonts.quantico(),
              ),
            ],
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
    _content = GameWidget(game: SpaceShooterGame(gameOver: endGame));
    gameRunning = true;
    setState(() {});
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
      _setTitleScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        //toolbarOpacity: 0,
        title: Text(
          'Weltraum Einwanderer',
          style: GoogleFonts.quantico(),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: _content,
      )),
    );
  }
}
